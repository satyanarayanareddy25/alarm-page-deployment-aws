output "bucket_name" {
  value = aws_s3_bucket.react_app_bucket.bucket
}

output "bucket_website_url" {
  value = aws_s3_bucket.react_app_bucket.website_endpoint
}
