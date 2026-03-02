# ─────────────────────────────────────────────
#  ROUTE 53 – Zone DNS + Records
# ─────────────────────────────────────────────

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# Record apex (younesallaoui.com) → CloudFront
resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.main.zone_id
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
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.myportfolio_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.myportfolio_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
