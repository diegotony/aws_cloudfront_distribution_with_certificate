variable "domain" {
  type        = string
  description = "(optional) describe your variable"
}

variable "subdomain" {
  type        = string
  description = "(optional) describe your variable"
}

variable "certificate" {
  type = object({
    ssl_support_method       = string
    minimum_protocol_version = string
  })

  default = {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

variable "custom_error_response" {
  type = list(object({
    error_caching_min_ttl = number,
    error_code            = number,
    response_code         = number,
    response_page_path    = string,
  }))
  
  default = [{
    error_caching_min_ttl = 1
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }]
}

variable "tags" {
  type = map(any)
  default = {
    "service" = "aws_cloudront_distribution"
  }
  description = "tags"
}

# TODO
# Add Validations
