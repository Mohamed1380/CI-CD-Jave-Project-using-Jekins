resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cider_block
  tags = var.tags
}