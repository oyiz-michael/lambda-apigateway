# variable "project_name" {
#   description = "The name of the project"
#   type        = string
# }

# variable "environment" {
#   description = "The deployment environment (e.g., dev, prod)"
#   type        = string
# }

variable "region" {
  description = "AWS region"
  type        = string
}

# variable "api_endpoints" {
#   description = "API Gateway endpoints structure"
#   type = map(object({
#     path_part     = string
#     http_method   = string
#     authorization = string
#     authorizer_id = string
#     lambda_arn    = string
#     parent_id     = string
#   }))
# }
