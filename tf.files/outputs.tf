output "cloudfront_url" {
  description = "URL of CloudFront distribution"
  value       = "https://${aws_cloudfront_distribution.myportfolio_distribution.domain_name}"
}

output "website_url" {
  description = "URL of website"
  value       = "https://${var.domain_name}"
}

output "s3_bucket_name" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.myportfolio.bucket
}

