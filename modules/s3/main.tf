resource "aws_s3_bucket" "agitask02_bucket" {
  bucket = var.bucket_name
  force_destroy = true
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "agitask02_bucket_versioning" {
  bucket = aws_s3_bucket.agitask02_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
} 


variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

output "bucket_id" {
  value = aws_s3_bucket.agitask02_bucket.id
}
