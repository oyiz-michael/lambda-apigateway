
resource "aws_api_gateway_resource" "Demo_v1" {
  rest_api_id = var.rest_api_id
  parent_id = var.parent_id
  path_part   = var.api_resource
}


