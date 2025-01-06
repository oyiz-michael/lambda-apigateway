# module "api_gateway_v1" {
#   source      = "../modules/Api-gateway/v1"
#   # project_name = "MyProject"
#   # environment  = "dev"
#   region       = "us-west-2"

#   api_resource_firstlevel = {

#     #/v1/titles
#     "titles" = {
#       path_part     = "titles"
#       # http_method   = "GET"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       parent_id     = ""
#     },

#     # /v1/common
#     "common" = {
#       path_part     = "common"
#       # http_method   = "NONE"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       parent_id       = ""
#     },

#     #/v1/titles/request/ratings
#     "ratings" = {
#       path_part     = "ratings"
#       # http_method   = "NONE"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       # parent_id     =  module.api_gateway_v1.api_resource_firstlevel_id.common.id
#       parent_id = ""
#     },

#     # #/v1/titles/request/talent-name
#     # "customization" = {
#     #   path_part     = "customization"
#     #   # http_method   = "POST"
#     #   # authorization = "NONE"
#     #   # authorizer_id = ""
#     #   # lambda_arn    = ""
#     #   parent_id     = ""
#     # },

#     # #/v1/titles/request/talent-name/search
#     # "search" = {
#     #   path_part     = "search"
#     #   # http_method   = "NONE"
#     #   # authorization = "NONE"
#     #   # authorizer_id = ""
#     #   # lambda_arn    = ""
#     #   parent_id     = ""
#     # },

#     "test1" = {
#       path_part     = "test1"
#       # http_method   = "NONE"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       parent_id     = ""
#     }
#   }

# ##second level resouce   
# ##--test 
#   api_resource_secondlevel = {

#     #/v1/common/token
#     "token" = {
#       path_part     = "token"
#       # http_method   = "POST"
#       # authorization = "CUSTOM"
#       # authorizer_id = "abcd1234"
#       # lambda_arn    = ""
#       parent_id       = module.api_gateway_v1.api_resource_firstlevel_id.common.id
#     },

#     #/v1/titles/metadata
#     "metadata" = {
#       path_part     = "metadata"
#       # http_method   = "PUT"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       parent_id     = module.api_gateway_v1.api_resource_firstlevel_id.titles.id
#     },

#     #/v1/titles/request/
#     "request" = {
#       path_part     = "request"
#       # http_method   = "NONE"
#       # authorization = "NONE"
#       # authorizer_id = ""
#       # lambda_arn    = ""
#       parent_id     = module.api_gateway_v1.api_resource_firstlevel_id.titles.id
#     },

#     # "metadata" = {
#     #   path_part     = "metadata"
#     #   # http_method   = "GET"
#     #   # authorization = "NONE"
#     #   # authorizer_id = ""
#     #   # lambda_arn    = ""
#     #   parent_id     = data.aws_api_gateway_resource.columns_resource.id
#     # },
#     # "boxoffice" = {
#     #   path_part     = "boxoffice"
#     #   # http_method   = "GET"
#     #   # authorization = "NONE"
#     #   # authorizer_id = ""
#     #   # lambda_arn    = ""
#     #   parent_id     = module.api_gateway_v1.api_resource_firstlevel_id.titles.id
#     # },
#     # "test2" = {
#     #   path_part     = "test2"
#     #   # http_method   = "NONE"
#     #   # authorization = "NONE"
#     #   # authorizer_id = ""
#     #   # lambda_arn    = ""
#     #   parent_id     = module.api_gateway_v1.api_resource_firstlevel_id.test1.id
#     # }
#   }
# }
 

