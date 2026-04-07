module "label_lambda_get_all_authors" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name    = "get-all-authors"
  context = module.label.context

}
module "label_lambda_get_all_courses" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name    = "get-all-courses"
  context = module.label.context

}

module "lambda_get_all_authors" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "8.7.0"
  function_name = module.label_lambda_get_all_authors.id
  description   = "My awesome lambda_get_all_authors lambda function"
  handler       = "index.handler"
  runtime       = "nodejs24.x"
  create_role   = false
  lambda_role   = module.iam_role_get_all_authors.arn

  source_path = "./src/lambdas/lambda_get_all_authors"

  tags = {
    Name = module.label_lambda_get_all_authors.id
  }
  environment_variables = {
    TABLE_NAME = module.table_author.id
  }
  create_current_version_allowed_triggers = false

  allowed_triggers = {
    APIGatewayDevPost = {
      service = "apigateway"
      # source_arn = "arn:aws:execute-api:eu-west-1:135367859851:aqnku8akd0/dev/POST/*"
      # source_arn = "${aws_api_gateway_stage.dev.execution_arn}/GET/authors"
      source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET/authors"
    }
  }
}

module "lambda_get_all_courses" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "8.7.0"
  function_name = module.label_lambda_get_all_courses.id
  description   = "My awesome lambda_get_all_courses lambda function"
  handler       = "index.handler"
  runtime       = "nodejs24.x"
  create_role   = false
  lambda_role   = module.iam_role_get_all_courses.arn

  source_path = "./src/lambdas/lambda_get_all_courses"

  tags = {
    Name = module.label_lambda_get_all_courses.id
  }
  environment_variables = {
    TABLE_NAME = module.table_course.id
  }
}
