#
# Minimal example of VPC setup for development environment
#
module "vpc_dev_exaple" {
  source = "github.com/peinser/tf-aws-landingzone-module-vpc"

  env = "dev"
  vpc_name = "vpc-dev"
}