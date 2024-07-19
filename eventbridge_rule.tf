resource "aws_cloudwatch_event_rule" "new_instance" {
  name        = "new-instance"
  description = "Capture ec2 instance state"

  event_pattern = jsonencode({
    source = [
      "aws.ec2"
    ],
    detail-type = [
      "EC2 Instance State-change Notification"
    ],
    detail = {
      state = [
        "running"
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.new_instance.name
  arn  = aws_lambda_function.mirror_on_new_instance.arn
}
