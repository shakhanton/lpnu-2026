
resource "aws_cloudwatch_log_group" "get_all_authors" {
  name = module.label_lambda_get_all_authors.id
}

resource "aws_cloudwatch_log_group" "get_all_courses" {
  name = module.label_lambda_get_all_courses.id
}
