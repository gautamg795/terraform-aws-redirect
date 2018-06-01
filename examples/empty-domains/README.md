# No Domain Example

Being able to pass in an empty map is useful if your certificate may depend on the workspace you're in. In this example one workspace would pass in a map of certificates and another wouldn't.

```hcl
variable "domains" {
  type = "map"

  default = {
    "default" = {}

    "production" = {
      "mediapop.co." = ["www.mediapop.co"]
    }
  }
}

module "cert" {
  source  = "mediapop/redirect/aws"
  domains = "${var.domains[var.workspace]}"
  redirect_to = "mediapop.co"
}
```
