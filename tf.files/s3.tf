# ─────────────────────────────────────────────
#  S3 – static website bucket
# ─────────────────────────────────────────────

resource "aws_s3_bucket" "myportfolio" {
  bucket = var.domain_name

  tags = {
    Name = "My portfolio website"
  }
}

resource "aws_s3_bucket_public_access_block" "myportfolio_access" {
  bucket = aws_s3_bucket.myportfolio.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "myportafolio_versionning" {
  bucket = aws_s3_bucket.myportfolio.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Policy S3 : only access from CloudFront (OAC)
resource "aws_s3_bucket_policy" "my_portfolio_policy" {
  bucket = aws_s3_bucket.myportfolio.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "AllowCloudFrontOAC"
      Effect = "Allow"
      Principal = {
        Service = "cloudfront.amazonaws.com"
      }
      Action   = "s3:GetObject"
      Resource = "${aws_s3_bucket.myportfolio.arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.myportfolio_distribution.arn
        }
      }
    }]
  })
}

# automatic uplod for index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.myportfolio.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  etag         = filemd5("index.html")
}

# automatic uplod for error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.myportfolio.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
  etag         = filemd5("error.html")
}