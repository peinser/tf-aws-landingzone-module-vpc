#
# Full example of a VPC setup with all variables defined
#
module "vpc_complete_example" {
  source = "github.com/peinser/tf-aws-landingzone-module-vpc"

  create_vpc = true
  env        = "dev"

  # VPC
  vpc_name = "vpc-dev"
  vpc_cidr = "10.0.0.0/16"

  # VPC flow logs
  create_vpc_flow_logs               = true # default: true if env == prod
  vpc_flow_logs_retention_days       = 7
  vpc_flow_logs_aggregation_interval = 600

  # Subnets
  create_database_subnets     = true
  private_subnet_name_prefix  = "private"
  public_subnet_name_prefix   = "public"
  database_subnet_name_prefix = "database"

  private_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]     # default used values when omitted
  public_subnet_cidr_blocks   = ["10.0.100.0/24", "10.0.101.0/24"] # default used values when omitted
  database_subnet_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"]   # default used values when omitted

  # NAT gateway
  create_nat_gateways = true
  single_nat_gateway  = true  # default: false if env == prod
  nat_gateway_per_az  = false # default: true if env == prod

  # VPC endpoints
  create_vpc_endpoints = true # currently only an S3 endpoint is configured
}