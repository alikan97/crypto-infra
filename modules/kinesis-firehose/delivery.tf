# resource "aws_cloudwatch_log_group" "temporary" {
#   name = "temp"
# }
# resource "aws_cloudwatch_log_stream" "temp" {
#   name           = "TempStream"
#   log_group_name = aws_cloudwatch_log_group.temporary.name
# }
resource "aws_kinesis_firehose_delivery_stream" "deliver" {
#   depends_on = [ aws_cloudwatch_log_group.temporary ]

  name = var.delivery_name
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = var.kinesis_stream_arn
    role_arn = aws_iam_role.firehose_role.arn
  }

  s3_configuration {
    role_arn = aws_iam_role.firehose_role.arn
    bucket_arn = var.s3_bucket_arn
    buffer_size = 5 #Mb, Buffer incoming data to 5Mb before delivering to s3 bucket
    buffer_interval = 60
    compression_format = "ZIP"

    # cloudwatch_logging_options {
    #   enabled = true
    #   log_group_name = aws_cloudwatch_log_group.temporary.name
    #   log_stream_name = aws_cloudwatch_log_stream.temp.name
    # }
  }
}
