output "kinesis_arn" {
  value       = aws_kinesis_stream.crypto-stream.arn
  description = "Kinesis ARN"
  sensitive   = false
}
