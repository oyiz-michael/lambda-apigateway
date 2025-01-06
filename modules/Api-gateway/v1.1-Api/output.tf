

output "MyDemoAPI" {
    value = aws_api_gateway_rest_api.MyDemoAPI.id
}


output "Demo_v1_resource_id" {
  value = aws_api_gateway_resource.Demo_v1.id
}

