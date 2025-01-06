# ### titles resouce id 
# data "aws_api_gateway_rest_api" "my_rest_api" {
#   name = "MyDemoAPI"
# }

# data "aws_api_gateway_resource" "columns_resource" {
#   rest_api_id = data.aws_api_gateway_rest_api.my_rest_api.id
#   path        = "/v1/columns"
# }

# data "aws_api_gateway_resource" "titles_resource" {
#   rest_api_id = data.aws_api_gateway_rest_api.my_rest_api.id
#   path        = "/v1/titles"
# }

# data "aws_api_gateway_resource" "test1_resource" {
#   rest_api_id = data.aws_api_gateway_rest_api.my_rest_api.id
#   path        = "/v1/test1"

# }

# output "api_resource_firstlevel_id" {
#     value = module.api_gateway_v1.api_resource_firstlevel_id
# }

# output "resource_secondlevel_id" {
#     value = module.api_gateway_v1.api_resource_secondlevel_id
# }

# # Reference the output in the parent module
# output "v1_resource_id_in_parent" {
#   description = "The ID of the v1 resource from the module"
#   value       = module.my_api_gateway.v1_resource_id
# }

# output "MyDemoAPI_id" {
#   value = module.Api-resource-demo.MyDemoAPI
# }

# output "lambda_invoke_arn" {
#   value = module.lambda_functions.invoke_arn
# }

# output "lambda_function_arn" {
#   value = module.lambda_functions.arn
# }

# output "api_integration_uri" {
#   value = module.v1_titles_request.integration_uri
# }