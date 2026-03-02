# ─────────────────────────────────────────────
#  CLOUDFRONT – Distribution
# ─────────────────────────────────────────────

# Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "myportfolio_oac" {
  name                              = "${var.domain_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "myportfolio_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [var.domain_name, "www.${var.domain_name}"]
  price_class         = "PriceClass_100" # Europe + Amérique du Nord

  origin {
    domain_name              = aws_s3_bucket.myportfolio.bucket_regional_domain_name
    origin_id                = "S3-${var.domain_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.myportfolio_oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }

    min_ttl     = 0
    default_ttl = 86400    # 1 jour
    max_ttl     = 31536000 # 1 an
  }

  # Error →  error.html
  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/error.html"
  }
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/error.html"
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  depends_on = [aws_acm_certificate_validation.cert]
}
