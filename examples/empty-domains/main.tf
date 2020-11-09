provider "aws" {
  region = "ap-southeast-1"
}

module "redirect" {
  source = "../../"

  domains = {
  }
  redirect_to = "mediapop.co"
}
