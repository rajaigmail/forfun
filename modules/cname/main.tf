resource "cloudflare_record" "cname" {

  type = "CNAME"

  zone_id = var.cf_zone_id
  name    = var.cf_cname
  value   = var.cf_target
  ttl     = var.cf_ttl
  proxied = var.cf_proxied
}


