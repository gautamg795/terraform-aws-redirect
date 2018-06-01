provider "aws" {
  region = "ap-southeast-1"
}

module "redirect" {
  source      = "../../"
  redirect_to = "https://mediapop.co"

  domains = {
    "uatdomains.com." = ["terraform-aws-redirect.uatdomains.com"]
  }
}
