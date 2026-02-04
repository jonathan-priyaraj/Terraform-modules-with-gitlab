module "prod_compute_1" {

  source      = "../modules/compute"
  environment = module.prod_vpc_1.environment
  amis = { us-east-1 = "ami-0b6c6ebed2801a5cb", us-east-2 = "ami-06e3c045d79fd65d9"
  }
  aws_region           = var.aws_region
  instance_type        = "t2.nano"
  key_name             = "new"
  iam_instance_profile = module.prod_iam_1.instprofile
  vpc_name             = module.prod_vpc_1.vpc_name
  public_subnets       = module.prod_vpc_1.public_subnets_id
  private_subnets      = module.prod_vpc_1.private_subnets_id
  sg_id                = module.prod_sg_1.sg_id
}

module "prod_iam_1" {
  source              = "../modules/iam"
  environment         = module.prod_vpc_1.environment
  role_name           = "JonathanProdITRole"
  instanceprofilename = "JonathanProdProfile"
}
