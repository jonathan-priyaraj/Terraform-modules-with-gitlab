module "dev_compute_1" {

  source      = "../modules/compute"
  environment = module.dev_vpc_1.environment
  amis = { us-east-1 = "ami-0b6c6ebed2801a5cb", us-east-2 = "ami-06e3c045d79fd65d9"
  }
  aws_region           = var.aws_region
  instance_type        = "t2.nano"
  key_name             = "new"
  iam_instance_profile = module.dev_iam_1.instprofile
  vpc_name             = module.dev_vpc_1.vpc_name
  public_subnets       = module.dev_vpc_1.public_subnets_id
  private_subnets      = module.dev_vpc_1.private_subnets_id
  sg_id                = module.dev_sg_1.sg_id
}

module "dev_elb_1" {

  source      = "../modules/elb"
  nlbname     = "dev-nlb"
  subnets     = module.dev_vpc_1.public_subnets_id
  environment = module.dev_vpc_1.environment
  tgname      = "dev-nlb-tg"
  vpc_id      = module.dev_vpc_1.vpc_id
  servers     = module.dev_compute_1.private_servers
}

module "dev_elb_public" {

  source      = "../modules/elb"
  nlbname     = "dev-nlb-public"
  subnets     = module.dev_vpc_1.public_subnets_id
  environment = module.dev_vpc_1.environment
  tgname      = "dev-nlb-tg-public"
  vpc_id      = module.dev_vpc_1.vpc_id
  servers     = module.dev_compute_1.public_servers
}

module "dev_iam_1" {
  source              = "../modules/iam"
  environment         = module.dev_vpc_1.environment
  role_name           = "JonathanITRole"
  instanceprofilename = "JonathanProfile"
}
