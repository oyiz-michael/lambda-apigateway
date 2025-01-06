variable "region" {
  default = "us-west-2"
}

variable "api_resource_firstlevel" {
  type = map(object({
    path_part     = string
    # http_method   = string
    # authorization = string
    # authorizer_id = string
    # lambda_arn    = string
    parent_id     = string
  }))
}

variable "api_resource_secondlevel" {
  type = map(object({
    path_part     = string
    # http_method   = string
    # authorization = string
    # authorizer_id = string
    # lambda_arn    = string
    parent_id     = string
  }))
}

# variable "api_resource_firstlevel_parentid" {
#   description = "firstlevel api resource parentid"
# }