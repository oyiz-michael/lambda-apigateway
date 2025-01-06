
# Define variables (you can also put these in a separate variables.tf file)
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "test_lambda_function"
}

variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  type        = string
  default     = "python3.8"
}

variable "lambda_zip_file" {
  description = "Path to the ZIP file containing the Lambda function code"
  type        = string
  default     = "lambda_function.zip"
}