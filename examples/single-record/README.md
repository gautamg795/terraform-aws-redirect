# Single domain redirect

```hcl
module "redirect" {
  source = "mediapop/redirect/aws"

  domains = {
    "uatdomains.com." = ["terraform-aws-redirect.uatdomains.com"]
  }

  redirect_to = "https://mediapop.co"
}
```
