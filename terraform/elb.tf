resource "aws_elb" "cf_sys_lb" {
  name            = "cf-sys-lb"
  security_groups = ["${aws_security_group.bosh.id}"]
  subnets         = ["${aws_subnet.public.id}"]
  internal        = false

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = 80
    instance_protocol  = "http"
    ssl_certificate_id = "${aws_acm_certificate.sys_cert.id}"
  }

  listener {
    lb_port            = 4443
    lb_protocol        = "ssl"
    instance_port      = 80
    instance_protocol  = "tcp"
    ssl_certificate_id = "${aws_acm_certificate.sys_cert.id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  tags {
    Name = "${var.stack_name}-cf-sys-lb"
  }
}

resource "aws_elb" "cf_app_lb" {
  name            = "cf-app-lb"
  security_groups = ["${aws_security_group.bosh.id}"]
  subnets         = ["${aws_subnet.public.id}"]
  internal        = false

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = 80
    instance_protocol  = "http"
    ssl_certificate_id = "${aws_acm_certificate.app_cert.id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  tags {
    Name = "${var.stack_name}-cf-app-lb"
  }
}

resource "aws_elb" "cf_ssh_lb" {
  name            = "cf-ssh-lb"
  security_groups = ["${aws_security_group.bosh.id}"]
  subnets         = ["${aws_subnet.public.id}"]
  internal        = false

  listener {
    lb_port           = 2222
    lb_protocol       = "tcp"
    instance_port     = 2222
    instance_protocol = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:2222"
    interval            = 30
  }

  tags {
    Name = "${var.stack_name}-cf-ssh-lb"
  }
}
