module "Api-resource-demo" {
  source = "../modules/Api-gateway/v1.1-Api"
  region = "us-west-2"
}

module "lambda_functions" {
  source = "../modules/lambda"
  lambda_function_name = "test1"
}

module "lambda_functions2" {
  source = "../modules/lambda"
  lambda_function_name = "test2"
}

# module "lambda_functions3" {
#   source = "../modules/lambda"
#   lambda_function_name = "test3"
# }

# module "lambda_functions4" {
#   source = "../modules/lambda"
#   lambda_function_name = "test4"
# }

####Titiles

#v1/titles
module "v1_titles" {
  source = "../modules/Api-gateway/v2.1"
  path_part = "titles"
  rest_api_id = module.Api-resource-demo.MyDemoAPI
  parent_id   = module.Api-resource-demo.Demo_v1_resource_id
  methods = [] #no methods
}

#v1/titles/test
module "v1_titles_test" {
  source = "../modules/Api-gateway/v2.1"
  path_part = "test"
  rest_api_id = module.Api-resource-demo.MyDemoAPI
  parent_id   = module.Api-resource-demo.Demo_v1_resource_id
  methods = ["GET"]
  lambda_arn = module.lambda_functions2.arn
  lambda_function_name = module.lambda_functions2.lambda_function_name

  depends_on = [module.lambda_functions3]
}

#v1/titles/test
module "v1_titles_test_put" {
  source = "../modules/Api-gateway/v2.1"
  path_part = "test"
  rest_api_id = module.Api-resource-demo.MyDemoAPI
  parent_id   = module.Api-resource-demo.Demo_v1_resource_id
  methods = ["PUT"]
  lambda_arn = module.lambda_functions3.arn
  lambda_function_name = module.lambda_functions3.lambda_function_name

  depends_on = [module.lambda_functions3]
}


# #v1/titles/request
# module "v1_titles_request" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "request"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_titles.resource_id
#   methods = ["GET"]
#   lambda_arn = module.lambda_functions.arn
#   lambda_function_name = module.lambda_functions.lambda_function_name

#   depends_on = [module.lambda_functions]
# }

# #v1/titles/request/common
# module "v1_titles_request_common" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "common"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_titles_request.resource_id
#   methods = ["GET", "PUT"]
#   lambda_arn = module.lambda_functions.arn
#   lambda_function_name = module.lambda_functions.lambda_function_name

#   # depends_on = [module.lambda_functions]
# }

# #v1/titles/request/common
# module "v1_titles_request_common_test" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "test"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_titles_request_common.resource_id
#   methods = ["GET", "POST"]
#   lambda_arn = module.lambda_functions.arn
#   lambda_function_name = module.lambda_functions4.lambda_function_name

#   # depends_on = [module.lambda_functions]
# }

# #v1/common
# module "v1_common" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "common"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.Api-resource-demo.Demo_v1_resource_id

#   # depends_on = [module.lambda_functions]
# }

# #v1/common/token
# module "v1_common_tokens" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "token_common"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_common.resource_id
# }

# #v1/common/token/test2
# module "v1_common_tokens_test2" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "test2"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_common_tokens.resource_id
#   methods = ["GET", "PUT"]
#   lambda_arn = module.lambda_functions3.arn
#   lambda_function_name = module.lambda_functions3.lambda_function_name

#   depends_on = [module.lambda_functions3]
# }

# #v1/common/users
# module "v1_common_users" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "users"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_common.resource_id
#   methods = ["GET"]
#   lambda_arn = module.lambda_functions2.arn
#   lambda_function_name = module.lambda_functions2.lambda_function_name

#   # depends_on = [module.lambda_functions]
# }

# #v1/common/users
# module "v1_common_users_test" {
#   source = "../modules/Api-gateway/v2.1"
#   path_part = "test"
#   rest_api_id = module.Api-resource-demo.MyDemoAPI
#   parent_id = module.v1_common_users.resource_id
# }