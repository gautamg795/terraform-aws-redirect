# Terraform Redirect

*This terraform module is maintained by [Media Pop](https://www.mediapop.co), a software consultancy. Hire us to solve your DevOps challenges.*

Set up a permanent redirect with HTTPS and IPv6 across a batch of domains.

# Usage

You can specify as many zones and records as you wish following this simple format:

```hcl
module "redirect" {
  source = "mediapop/redirect/aws"

  domains = {
    "mediapop.co."     = ["www.mediapop.co"]
    "mediapopinc.com." = ["mediapopinc.com", "www.mediapopinc.com"]
  }

  redirect_to = "mediapop.co"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domains | Map of records to redirect from, with the zones as the keys. | map | - | yes |
| redirect_to | The target | string | - | yes |

## License

MIT
