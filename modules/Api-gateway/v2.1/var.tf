# variables.tf

variable "rest_api_id" {
  type = string
}

variable "parent_id" {
  type = string
}

variable "path_part" {
  type = string
}

variable "methods" {
  description = "List of HTTP methods for the resource"
  type        = list(string)
  default     = []
}

variable "lambda_invoke_arn" {
  description = "Lambda function ARN to integrate with"
  type        = string
  default     = ""
}

variable "create_options_method" {
  description = "Whether to create an OPTIONS method"
  type        = bool
  default     = true
}

variable "create_integration" {
  description = "Whether to create an integration for the methods"
  type        = bool
  default     = true
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  default = "427613144745"
}


variable "lambda_function_name" {
  description = "The name of the Lambda function to integrate with API Gateway"
  type        = string
  default     = null
}

variable "environment" {
  default = "Dev"
}