# outputs.tf

output "resource_id" {
  value = aws_api_gateway_resource.this.id
}

output "path" {
  value = aws_api_gateway_resource.this.path
}

output "integration_uri" {
  value = var.lambda_arn != "" ? "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations" : ""
}

# output "api_resource_firstlevel_id" {
#   value = {
#     for first in aws_api_gateway_resource.this : first.path_part => first 
#   }
# }