#
# Minimal example of VPC setup for production environment
#
module "vpc_prod_example" {
  source = "github.com/peinser/tf-aws-landingzone-module-vpc"

  env = "prod"

  # VPC
  vpc_name = "prod"
  vpc_cidr = "10.1.0.0/16"

  # VPC flow logs
  vpc_flow_logs_retention_days = 60

  # NAT gateway
  nat_gateway_per_az = true 
}