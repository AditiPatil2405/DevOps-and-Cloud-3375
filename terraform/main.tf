provider "aws" {
  region = "ca-central-1"
}

resource "aws_s3_bucket" "S3" {
  bucket = "my-test3-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}