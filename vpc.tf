data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

######################################
# VPC configuration
######################################

module "vpc" {
  count = var.create_vpc ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws" # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  version = "5.7.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = local.azs

  # ------------------------------------------------------------------------------------

  # VPC defaults
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  # ------------------------------------------------------------------------------------

  # Subnet CIDRs
  private_subnets  = length(var.private_subnet_cidr_blocks) == 0 ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 1)] : var.private_subnet_cidr_blocks
  public_subnets   = length(var.public_subnet_cidr_blocks) == 0 ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 100)] : var.public_subnet_cidr_blocks
  database_subnets = var.create_database_subnets && length(var.database_subnet_cidr_blocks) == 0 ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)] : var.create_database_subnets && length(var.database_subnet_cidr_blocks) > 0 ? var.database_subnet_cidr_blocks : []

  # Subnet naming
  private_subnet_names = [
    "${var.private_subnet_name_prefix}-${local.azs[0]}",
    "${var.private_subnet_name_prefix}-${local.azs[1]}"
  ]
  public_subnet_names = [
    "${var.public_subnet_name_prefix}-${local.azs[0]}",
    "${var.public_subnet_name_prefix}-${local.azs[1]}"
  ]
  database_subnet_names = [
    "${var.database_subnet_name_prefix}-${local.azs[0]}",
    "${var.database_subnet_name_prefix}-${local.azs[1]}"
  ]

  # Subnet parameters
  create_database_subnet_route_table = var.create_database_subnets ? true : false
  map_public_ip_on_launch            = true

  # ------------------------------------------------------------------------------------

  # NAT gateway
  enable_nat_gateway     = var.create_nat_gateways
  reuse_nat_ips          = false
  single_nat_gateway     = var.env == "dev" || var.single_nat_gateway ? true : false
  one_nat_gateway_per_az = var.env == "prod" || var.nat_gateway_per_az ? true : false

  # ------------------------------------------------------------------------------------

  # VPC flow logs
  enable_flow_log                                 = var.env == "prod" || var.create_vpc_flow_logs ? true : false
  create_flow_log_cloudwatch_log_group            = true
  create_flow_log_cloudwatch_iam_role             = true
  flow_log_max_aggregation_interval               = var.vpc_flow_logs_aggregation_interval
  flow_log_cloudwatch_log_group_retention_in_days = var.vpc_flow_logs_retention_days
  flow_log_cloudwatch_log_group_name_suffix       = var.env

  # ------------------------------------------------------------------------------------

  # Tagging - VPC
  vpc_tags = { Name = var.vpc_name }

  # Tagging - VPC flow logs
  vpc_flow_log_tags = { Name = "${var.vpc_name}-vpc-flow-logs" }

  # Tagging - NAT
  nat_gateway_tags = { Name = "${var.env}-nat-${element(local.azs, count.index)}" }

  # Tagging - NAT EIP
  nat_eip_tags = { Name = "${var.env}-eip-nat-${element(local.azs, count.index)}" }

  # Tagging - IGW
  igw_tags = { Name = "${var.env}-igw" }

  # Tagging - Route tables
  private_route_table_tags  = { Name = "${var.env}-rt-private" }
  public_route_table_tags   = { Name = "${var.env}-rt-public" }
  database_route_table_tags = { Name = "${var.env}-rt-database" }

  # Generic tags applied to all resources
  tags = {
    "peinser-lz:tf-managed" = "true"
    "peinser-lz:env"        = var.env
  }
}