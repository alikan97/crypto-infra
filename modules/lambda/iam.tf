resource "aws_iam_role" "lambda_func_role" {
  name = "${var.function_name}-${var.ecr_repository_name}-role"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "read_from_kinesis" {
  name   = "Lambda-Kinesis_read_policy"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kinesis:DescribeStream",
                "kinesis:DescribeStreamSummary",
                "kinesis:GetRecords",
                "kinesis:GetShardIterator",
                "kinesis:ListShards",
                "kinesis:ListStreams",
                "kinesis:SubscribeToShard"
            ],
            "Resource": "*"
        }
    ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "kinesis_execution" {
  role       = aws_iam_role.lambda_func_role.name
  policy_arn = aws_iam_policy.read_from_kinesis.arn
}
