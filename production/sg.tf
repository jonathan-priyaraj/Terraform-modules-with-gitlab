module "prod_sg_1" {
  source        = "../modules/sg"
  vpc_id        = module.prod_vpc_1.vpc_id
  vpc_name      = module.prod_vpc_1.vpc_name
  service_ports = ["80", "443", "445", "8080", "22", "3389"]
  environment   = module.prod_vpc_1.environment

}
