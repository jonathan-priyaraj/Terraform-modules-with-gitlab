variable "nlbname" {}
variable "subnets" {}
variable "environment" {}
variable "tgname" {}
variable "vpc_id" {}
variable "servers" {
  type = list(string)
}
