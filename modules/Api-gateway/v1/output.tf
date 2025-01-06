# output "v1_resource" {
#   value = aws_api_gateway_resource.Demo_v1.id
# }

# output "MyDemoAPI" {
#     value = aws_api_gateway_rest_api.MyDemoAPI.id
# }

output "api_resource_firstlevel_id" {
  value = {
    for first in aws_api_gateway_resource.api_resource_firstlevel : first.path_part => first 
  }
}

output "api_resource_secondlevel_id" {
  value = {
    for first in aws_api_gateway_resource.api_resource_secondlevel : first.path_part => first
  }
}