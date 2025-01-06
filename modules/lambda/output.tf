# output "lambda_invoke_arn" {
#   value = aws_lambda_function.test_lambda.invoke_arn
# }

# outputs.tf

output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.test_lambda.function_name
}

# output "invoke_arn" {
#   description = "Invoke ARN of the Lambda function"
#   value       = aws_lambda_function.test_lambda.invoke_arn
# }

output "arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.test_lambda.arn
}


output "lambda_function_name" {
  value = aws_lambda_function.test_lambda.function_name
}