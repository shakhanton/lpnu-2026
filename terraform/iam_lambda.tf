data "aws_iam_policy_document" "authors" {
  statement {
    sid = "1"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:Scan"
    ]

    resources = [
      module.table_author.arn
    ]
  }
  statement {
    sid = "2"

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]

    resources = [
      "${aws_cloudwatch_log_group.get_all_authors.arn}:*:*",
      "${aws_cloudwatch_log_group.get_all_authors.arn}:*"
    ]
  }

}
data "aws_iam_policy_document" "courses" {
  statement {
    sid = "1"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:Scan"
    ]

    resources = [
      module.table_course.arn
    ]
  }
  statement {
    sid = "2"

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]

    resources = [
      "${aws_cloudwatch_log_group.get_all_courses.arn}:*:*",
      "${aws_cloudwatch_log_group.get_all_courses.arn}:*"
    ]
  }

}


module "iam_policy_get_all_authors" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version     = "6.4.0"
  name        = module.label_lambda_get_all_authors.id
  path        = "/"
  description = "get_all_authors"

  policy = data.aws_iam_policy_document.authors.json

}

module "iam_policy_get_all_courses" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version     = "6.4.0"
  name        = module.label_lambda_get_all_courses.id
  path        = "/"
  description = "get_all_courses"

  policy = data.aws_iam_policy_document.courses.json

}

module "iam_role_get_all_authors" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.4.0"
  name    = module.label_lambda_get_all_authors.id

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
      ]
      principals = [{
        type = "Service"
        identifiers = [
          "lambda.amazonaws.com",
        ]
      }]
    }
  }

  policies = {


    custom = module.iam_policy_get_all_authors.arn
  }

}
module "iam_role_get_all_courses" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.4.0"
  name    = module.label_lambda_get_all_courses.id

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
      ]
      principals = [{
        type = "Service"
        identifiers = [
          "lambda.amazonaws.com",
        ]
      }]
    }
  }

  policies = {


    custom = module.iam_policy_get_all_courses.arn
  }

}
