resource "aws_route53_record" "system_domain" {
  zone_id = "${var.hosted_zone_id}"
  name    = "*.sys.${var.stack_name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "${aws_elb.cf_sys_lb.dns_name}",
  ]
}

resource "aws_route53_record" "app_domain" {
  zone_id = "${var.hosted_zone_id}"
  name    = "*.app.${var.stack_name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "${aws_elb.cf_app_lb.dns_name}",
  ]
}

resource "aws_route53_record" "ssh" {
  zone_id = "${var.hosted_zone_id}"
  name    = "ssh.sys.${var.stack_name}"
  type    = "CNAME"
  ttl     = 300

  records = [
    "${aws_elb.cf_ssh_lb.dns_name}",
  ]
}
