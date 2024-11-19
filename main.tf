
resource "aws_s3_bucket" "react_app_bucket" {
  bucket        = var.bucket_name
  force_destroy = true # Allows Terraform to delete non-empty buckets
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "react_app_policy" {
  bucket = aws_s3_bucket.react_app_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.react_app_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket              = aws_s3_bucket.react_app_bucket.bucket
  block_public_policy = true
}





