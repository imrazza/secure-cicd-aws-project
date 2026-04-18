provider "aws" {
  region = "us-east-1"
}

# KMS Key (Customer Managed)
resource "aws_kms_key" "s3_key" {
  description             = "S3 bucket CMK"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/s3-demo-key"
  target_key_id = aws_kms_key.s3_key.key_id
}

# S3 Bucket
resource "aws_s3_bucket" "demo" {
  bucket = "my-devsecops-demo-bucket"
}

# Block public access
resource "aws_s3_bucket_public_access_block" "demo" {
  bucket                  = aws_s3_bucket.demo.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable SSE-KMS encryption (FIX for AWS-0132)
resource "aws_s3_bucket_server_side_encryption_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
