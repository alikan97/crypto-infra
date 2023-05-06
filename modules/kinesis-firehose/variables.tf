variable "delivery_name" {
  description = "Name of delivery stream"
}

variable "s3_bucket_arn" {
    description = "ARN of the destination s3 bucket"
}

variable "kinesis_stream_arn" {
    description = "ARN of the source kinesis stream"
}

variable "firehose_role" {
  description = "The name of the firehose role"
}

variable "firehose_policy_name" {
    description = "Policy name for Kinesis firehose to s3"
}