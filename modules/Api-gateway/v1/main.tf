resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "Demo_v1" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "api_resource_firstlevel" {
  for_each    = var.api_resource_firstlevel
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id = coalesce(each.value.parent_id, aws_api_gateway_resource.Demo_v1.id)
  
  path_part   = each.value.path_part

  depends_on = [ aws_api_gateway_resource.Demo_v1 ]
}


resource "aws_api_gateway_resource" "api_resource_secondlevel" {
  for_each = var.api_resource_secondlevel
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id = coalesce(each.value.parent_id, aws_api_gateway_resource.Demo_v1.id)
  path_part = each.value.path_part

  depends_on = [ aws_api_gateway_resource.api_resource_firstlevel ]
}


# resource "aws_api_gateway_method" "api_method" {
#   for_each    = var.api_resource_firstlevel
#   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
#   resource_id = aws_api_gateway_resource.api_resource[each.key].id
#   http_method = each.value.http_method
#   authorization = each.value.authorization
#   authorizer_id = each.value.authorizer_id != "" ? each.value.authorizer_id : null
# }

# resource "aws_api_gateway_integration" "lambda_integration" {
#   for_each    = var.api_endpoints
#   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
#   resource_id = aws_api_gateway_resource.api_resource[each.key].id
#   http_method = aws_api_gateway_method.api_method[each.key].http_method

#   type                 = "AWS_PROXY"
#   integration_http_method = "POST"
#   uri                  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${each.value.lambda_arn}/invocations"
# }