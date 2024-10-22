resource "aws_s3_bucket" "s3_iti" {
  bucket = "myfinalproject-iti"

  tags = {
    Name        = "Project Bucket"
    Environment = "Dev"
  }
}