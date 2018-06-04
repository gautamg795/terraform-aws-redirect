variable "domains" {
  type        = "map"
  description = "A map {\"zone.com.\" = [\"zone.com\",\"www.zone.com\"],\"foo.com\" = [\"foo.com\"] } of domains."
}

variable "redirect_to" {
  description = "The redirect target, the protoctol is optional as https:// will always be enforced."
}

locals {
  records      = "${keys(transpose(var.domains))}"
  redirect_to = "${replace(var.redirect_to, "/^(?:https?://)?/", "https://")}"
  bucket_name = "redirect-${replace(replace(local.redirect_to, "https://", ""), "/\\W/", "")}"
}
