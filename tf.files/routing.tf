# ─────────────────────────────────────────────
#  ROUTE 53 – Zone DNS + Records
# ─────────────────────────────────────────────

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# Record apex (younes-allaoui.fr) → CloudFront
resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.myportfolio_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.myportfolio_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# Record www (www.younes-allaoui.fr) → CloudFront
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.myportfolio_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.myportfolio_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
