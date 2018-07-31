# NAT Elastic IP
resource "aws_eip" "webapp" {
  vpc = true

   tags {
    Name       = "${var.stack_name}-webapp"
  }
}