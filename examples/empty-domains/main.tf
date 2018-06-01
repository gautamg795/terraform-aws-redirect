provider "aws" {
  region  = "ap-southeast-1"
  version = "~> 1.21.0"
}

module "redirect" {
  source = "../../"

  domains = {
  }
  redirect_to = "mediapop.co"
}
