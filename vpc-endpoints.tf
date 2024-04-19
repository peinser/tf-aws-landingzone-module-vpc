locals {
  vpc = module.vpc[0] # module.vpc is a list because we use the count variable as a conditional operator
}

######################################
#	VPC Endpoint configuration
######################################

module "vpc_endpoints" {
  count = var.env == "prod" || var.create_vpc_endpoints ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.7.1"

  vpc_id = local.vpc.vpc_id

  # ------------------------------------------------------------------------------------

  create_security_group      = true
  security_group_name = "${var.vpc_name}-vpc-endpoint"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [local.vpc.vpc_cidr_block]
    }
  }

  # ------------------------------------------------------------------------------------

  endpoints = {
    s3 = {
      service             = "s3"
      private_dns_enabled = true
      dns_options = {
        private_dns_only_for_inbound_resolver_endpoint = false
      }
      tags = { Name = "vpc-${var.env}-s3-endpoint"}
    },
  }
}

# ------------------------------------------------------------------------------------


######################################
#	VPC Endpoints - Generic IAM policy
# Deny all traffic outside source VPC
######################################

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [local.vpc.vpc_id]
    }
  }
}