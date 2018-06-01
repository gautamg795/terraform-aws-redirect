variable "domains" {
  type        = "map"
  description = "A map {\"zone.com.\" = [\"zone.com\",\"www.zone.com\"],\"foo.com\" = [\"foo.com\"] } of domains."
}

locals {
  records      = "${keys(transpose(var.domains))}"
  bucket_name = "redirect-${replace(var.redirect_to, "/\\W/", "")}"
}

variable "redirect_to" {
  description = "To where the redirect requests should be sent"
}
