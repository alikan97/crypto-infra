resource "aws_kinesis_stream" "crypto-stream" {
    name = var.stream_name
    shard_count = 1     # Use single shard to preserve ordering
    retention_period = 24   #hr

    shard_level_metrics = [ "IncomingRecords", "OutgoingRecords" ]

    tags = {
      "Name" = "${var.stream_name}"
    }
}