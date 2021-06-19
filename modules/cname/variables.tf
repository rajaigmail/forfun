variable "cf_cname" {
  type = string
}

variable "cf_target" {
  type = string
}

variable "cf_ttl" {
  type    = string
  default = "0"
}

variable "cf_proxied" {
  type    = bool
  default = true
}

variable "cf_zone_id" {
  type = string
}
