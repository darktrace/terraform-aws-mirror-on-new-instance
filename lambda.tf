resource "aws_lambda_function" "mirror_on_new_instance" {
  filename      = "${path.module}/files/mirror-on-new-instance.zip"
  function_name = "mirror-on-new-instance"
  architectures = var.lambda_architecture

  role    = aws_iam_role.mirror_lambda_permissions.arn
  handler = "index.handler"
  runtime = "nodejs18.x"
  timeout = 30

  environment {
    variables = {
      SESSION_NUMBER           = var.session_number
      TAG_KEY                  = var.tag_key
      TAG_VALUE                = var.tag_value
      TRAFFIC_MIRROR_FILTER_ID = var.traffic_mirror_filter_id
      TRAFFIC_MIRROR_TARGET_ID = var.traffic_mirror_target_id
      VIRTUAL_NETWORK_ID       = var.virtual_network_id
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mirror_on_new_instance.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.new_instance.arn
}
