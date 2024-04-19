######################################
#	Provider variables
######################################

variable "region" {
  type    = string
  default = "eu-west-1"
}

# ------------------------------------------------------------------------------------


######################################
#	Account variables
######################################

variable "env" {
  type        = string
  description = "Environment of the configuration (dev|prod)"

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Invalid environment provided. Only values allowed are: dev, prod"
  }
}

# ------------------------------------------------------------------------------------


######################################
#	VPC variables
######################################

variable "create_vpc" {
  type        = bool
  description = "Whether to create the VPC configuration"
  default = true
}

variable "vpc_name" {
  type        = string
  description = "Name of the main VPC"
  default     = "vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the main VPC"
  default     = "10.0.0.0/16"
}

# ------------------------------------------------------------------------------------


######################################
#	VPC Flow Logs variables
######################################

variable "create_vpc_flow_logs" {
  type = bool
  description = "Whether to create VPC flow log resources. Enabled by default for prod environments"
  default = false
}

variable "vpc_flow_logs_retention_days" {
  type = number
  description = "Retention (in days) that VPC flow logs are kept"
  default = 30

  validation {
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#retention_in_days
    condition = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.vpc_flow_logs_retention_days)
    error_message = "Invalid value for VPC flow log retention. Possible values: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653"
  }
}

variable "vpc_flow_logs_aggregation_interval" {
  type = number
  description = "The maximum interval of time (in seconds) during which a flow of packets is captured and aggregated into a flow log record"
  default = 600

  validation {
    condition = contains([60, 600], var.vpc_flow_logs_aggregation_interval)
    error_message = "Invalid value for VPC flow log aggregation interval. Possible values: 60, 600"
  }
}

# ------------------------------------------------------------------------------------


######################################
#	Subnet variables
######################################

variable "create_database_subnets" {
  type        = bool
  description = "Whether to create database subnets"
  default     = true
}

variable "private_subnet_name_prefix" {
  type        = string
  description = "Prefix to add to private subnet names"
  default     = "private"
}

variable "public_subnet_name_prefix" {
  type        = string
  description = "Prefix to add to private subnet names"
  default     = "public"
}

variable "database_subnet_name_prefix" {
  type        = string
  description = "Prefix to add to database subnet names"
  default     = "database"
}

variable "private_subnet_cidr_blocks" {
  type = list
  description = "A list of CIDR blocks to use for private subnets"
  default = []
}

variable "public_subnet_cidr_blocks" {
  type = list
  description = "A list of CIDR blocks to use for public subnets"
  default = []
}

variable "database_subnet_cidr_blocks" {
  type = list
  description = "A list of CIDR blocks to use for database subnets"
  default = []
}

# ------------------------------------------------------------------------------------


######################################
#	NAT Gateway variables
######################################

variable "create_nat_gateways" {
  type = bool
  description = "Whether to create the NAT gateway resource(s)"
  default = true
}

variable "single_nat_gateway" {
  type = bool
  description = "Whether to create only a single NAT GW in the VPC"
  default = false
}

variable "nat_gateway_per_az" {
  type = bool
  description = "Whether to create a NAT gateway in each configured AZ. Enabled by default for prod environments"
  default = false
}

# ------------------------------------------------------------------------------------


######################################
#	VPC Endpoints variables
######################################

variable "create_vpc_endpoints" {
  type        = bool
  description = "Whether to create the VPC S3 endpoint configuration. Enabled by default for prod environments"
  default = false
}