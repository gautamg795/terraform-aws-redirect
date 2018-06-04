module "certificate" {
  source  = "mediapop/certificate/aws"
  version = "1.1.0"
  domains = "${var.domains}"
}

resource "aws_s3_bucket" "301" {
  count = "${length(var.domains) > 0 ? 1 : 0}"
  bucket_prefix = "${local.bucket_name}"

  website {
    redirect_all_requests_to = "${var.redirect_to}"
  }
}

resource "aws_cloudfront_distribution" "redirect" {
  count = "${length(var.domains) > 0 ? 1 : 0}"

  comment = "Redirects to ${var.redirect_to}. Managed by terraform-aws-301-redirect."

  "origin" {
    domain_name = "${aws_s3_bucket.301.website_endpoint}"
    origin_id   = "website"

    custom_origin_config {
      origin_protocol_policy = "https-only"
      http_port              = "80"
      https_port             = "443"

      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  aliases = "${local.records}"

  "default_cache_behavior" {
    allowed_methods = [
      "HEAD",
      "GET",
    ]

    cached_methods = [
      "HEAD",
      "GET",
    ]

    "forwarded_values" {
      query_string = false

      "cookies" {
        forward = "none"
      }
    }

    target_origin_id       = "website"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  "viewer_certificate" {
    acm_certificate_arn      = "${module.certificate.arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

module "mediapopco-redirect-records" {
  source  = "mediapop/route53-alias/aws"
  version = "1.1"

  domains              = "${var.domains}"
  alias_domain_name    = "${element(concat(aws_cloudfront_distribution.redirect.*.domain_name, list("")), 0)}"
  alias_hosted_zone_id = "${element(concat(aws_cloudfront_distribution.redirect.*.hosted_zone_id, list("")), 0)}"
}
