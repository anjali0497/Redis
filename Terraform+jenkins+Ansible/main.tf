module "vpc" {
  source = "./vpc"
  vpc-cidr = var.vpc-cidr
  nat-gat-id = module.subnet.nat-gat-id
  pri-sub-id = module.subnet.pri-sub-1-id
  pub-sub-id = module.subnet.pub-sub-id

}

module "subnet" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
  vpc-cidr = module.vpc.vpc-cidr
}

module "security_groups" {
  source = "./security-group"
  vpc-id = module.vpc.vpc_id
}

module "instance" {
  source = "./instances"
  pri-sub-1-id = module.subnet.pri-sub-1-id
  pri-sub-2-id = module.subnet.pri-sub-2-id
  pub-sub-id = module.subnet.pub-sub-id
  private-sg-id = module.security_groups.private-sg-id
  public-sg-id = module.security_groups.public-sg-id
}