# main.tf

# Create the API resource
resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = var.path_part
}

# Conditionally create methods
resource "aws_api_gateway_method" "methods" {
  for_each = toset(var.methods)
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = each.value
  authorization = "NONE"
}

# Always create integrations for methods
resource "aws_api_gateway_integration" "integrations" {
  for_each = aws_api_gateway_method.methods

  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = each.value.http_method

  type                    = var.lambda_arn != "" ? "AWS_PROXY" : "MOCK"
  integration_http_method = var.lambda_arn != "" ? "POST" : null
  uri                     = var.lambda_arn != "" ? "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations" : null

  request_templates = var.lambda_arn != "" ? null : {
    "application/json" = "{\"statusCode\": 200}"
  }

  passthrough_behavior = var.lambda_arn != "" ? null : "WHEN_NO_MATCH"

  depends_on = [
    aws_api_gateway_method.methods
  ]
}

# resource "aws_api_gateway_integration" "integrations" {
#   for_each = aws_api_gateway_method.methods

#   rest_api_id = var.rest_api_id
#   resource_id = aws_api_gateway_resource.this.id
#   http_method = each.value.http_method

#   type                    = var.lambda_function_name != null ? "AWS_PROXY" : "MOCK"
#   integration_http_method = var.lambda_function_name != null ? "POST" : null
#   uri                     = var.lambda_function_name != null ? "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda_function_name}/invocations" : null

#   request_templates = var.lambda_function_name != null ? null : {
#     "application/json" = "{\"statusCode\": 200}"
#   }

#   passthrough_behavior = var.lambda_function_name != null ? null : "WHEN_NO_MATCH"

#   depends_on = [
#     aws_api_gateway_method.methods
#   ]
# }

# Define the status codes
# Define the status codes you want to handle
locals {
  response_status_codes = ["200", "400", "500"]
  method_status_combinations = flatten([
    for method_key, method_value in aws_api_gateway_method.methods : [
      for status_code in local.response_status_codes : {
        method_key   = method_key
        method_value = method_value
        status_code  = status_code
      }
    ]
  ])
}

# Method Responses
resource "aws_api_gateway_method_response" "method_responses" {
  for_each = {
    for combination in local.method_status_combinations : "${combination.method_key}_${combination.status_code}" => combination
  }

  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = each.value.method_value.http_method
  status_code = each.value.status_code

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Content-Type" = false
  }
}

resource "aws_lambda_permission" "apigw" {
  count = var.lambda_function_name != null ? 1 : 0

  statement_id  = "AllowAPIGatewayInvoke_${var.parent_id}_${var.path_part}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/*/**"
}

# Determine if methods are defined
locals {
  has_methods = length(var.methods) > 0
}

# Automatically create OPTIONS method if methods are defined
resource "aws_api_gateway_method" "options" {
  count        = local.has_methods ? 1 : 0
  rest_api_id  = var.rest_api_id
  resource_id  = aws_api_gateway_resource.this.id
  http_method  = "OPTIONS"
  authorization = " "
}

# Integration for OPTIONS method
resource "aws_api_gateway_integration" "options_integration" {
  count        = length(aws_api_gateway_method.options)
  rest_api_id  = var.rest_api_id
  resource_id  = aws_api_gateway_resource.this.id
  http_method  = "OPTIONS"
  type         = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  passthrough_behavior = "WHEN_NO_MATCH"

  depends_on = [
    aws_api_gateway_method.options
  ]
}

# Method response for OPTIONS
resource "aws_api_gateway_method_response" "options_response" {
  count        = length(aws_api_gateway_method.options)
  rest_api_id  = var.rest_api_id
  resource_id  = aws_api_gateway_resource.this.id
  http_method  = "OPTIONS"
  status_code  = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# Integration response for OPTIONS
# Integration response for OPTIONS
resource "aws_api_gateway_integration_response" "options_integration_response" {
  count        = length(aws_api_gateway_method.options)
  rest_api_id  = var.rest_api_id
  resource_id  = aws_api_gateway_resource.this.id
  http_method  = "OPTIONS"
  status_code  = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'${join(",", concat(var.methods, ["OPTIONS"]))}'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_integration.options_integration,
    aws_api_gateway_method.options,
    aws_api_gateway_method_response.options_response
  ]
}

# resource "aws_api_gateway_deployment" "deployment" {
#   count        = local.has_methods ? 1 : 0

#   rest_api_id = var.rest_api_id

#   depends_on = [
#     aws_api_gateway_method.methods,
#     # Add any other dependencies as needed
#   ]

#   triggers = {
#     redeployment = sha1(jsonencode(local.deployment_trigger))
#   }
# }


# locals {
#   deployment_trigger = {
#     methods       = [for m in aws_api_gateway_method.methods : m.id]
#     integrations  = [for i in aws_api_gateway_integration.integrations : i.id]
#     resources     = [aws_api_gateway_resource.this.id]
#     method_responses = [for mr in aws_api_gateway_method_response.method_responses : mr.id]
#     # Include other elements like options, integration responses, etc., if necessary
#   }
# }



# resource "aws_api_gateway_stage" "example" {
#   deployment_id = aws_api_gateway_deployment.deployment.id
#   rest_api_id   = var.rest_api_id
#   stage_name    = "example"
# }