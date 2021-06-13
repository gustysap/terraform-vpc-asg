locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "vpc" {
  source = "./modules/vpc"

  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnets_cidr  = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zones   = "${local.availability_zones}"
}

module "asg" {
  source = "./modules/asg"
  
  private_subnets_id   = module.vpc.private_subnets_id
  security_groups_ids  = module.vpc.security_groups_ids
  vpc_id               = module.vpc.vpc_id
  environment          = "${var.environment}"
  image_id             = "${var.image_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
}
