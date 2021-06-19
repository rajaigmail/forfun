variable "instance_count" {
  default = "3"
  type    = string
}
variable "apache_ec2-instance_type" {
  default = "m5.large"
  type    = string

}
variable "ec2_pem_file" {
  default = "new-desi-techie"
  type    = string
}
variable "cf_cname" {
  type    = string
  default = "magic"
}

variable "cf_target" {
  type    = string
  default = "www.example.com"
}

variable "cf_ttl" {
  type    = string
  default = "0"
}

variable "cf_proxied" {
  type    = bool
  default = true
}


variable "cf_zone" {
  type    = string
  default = "in-ops.in"
}



variable "ami" {
  type    = string
  default = "ami-01104c435fb1f1412"
}

variable "vpc-name" {
  type    = string
  default = "mahesh-project-vpc"
}


variable "acm_arn" {

  type = string

  default = "arn:aws:acm:ap-south-1:623164150455:certificate/08307b92-3a8b-49a3-96ea-187957aceb50"

}

///////////////////////


data "cloudflare_zones" "website" {
  filter {
    name = var.cf_zone
  }
}

