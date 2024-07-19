resource "aws_iam_role" "mirror_lambda_permissions" {
  name = "Mirror-Lambda-Permissions"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "mirror_lambda_minimal_permissions" {
  statement {
    sid    = "MirrorLambdaMinimalPermissions"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:CreateTrafficMirrorSession",
      "ec2:CreateTags"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "mirror_lambda_minimal_permissions" {
  name        = "Mirror-Lambda-Minimal-Permissions"
  description = "Policy required by the Lambda function"
  policy      = data.aws_iam_policy_document.mirror_lambda_minimal_permissions.json
}

resource "aws_iam_role_policy_attachment" "mirror_lambda_minimal_permissions" {
  role       = aws_iam_role.mirror_lambda_permissions.name
  policy_arn = aws_iam_policy.mirror_lambda_minimal_permissions.arn
}

data "aws_iam_policy" "lambda_basic_execution_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_poicy" {
  role       = aws_iam_role.mirror_lambda_permissions.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution_role.arn
}
