resource "aws_iam_role" "firehose_role" {
  name = var.firehose_role

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "firehose_stream_policy" {
  name = var.firehose_policy_name
  role = aws_iam_role.firehose_role.id

  policy = jsonencode({
    Statement = [
      {
        Effect   = "Allow",
        Action   = "kinesis:*",
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = ["${var.s3_bucket_arn}"]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
