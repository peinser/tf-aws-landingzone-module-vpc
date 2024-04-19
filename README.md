<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.7.1 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 5.7.1 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_database_subnets"></a> [create\_database\_subnets](#input\_create\_database\_subnets) | Whether to create database subnets | `bool` | `true` | no |
| <a name="input_create_nat_gateways"></a> [create\_nat\_gateways](#input\_create\_nat\_gateways) | Whether to create the NAT gateway resource(s) | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Whether to create the VPC configuration | `bool` | `true` | no |
| <a name="input_create_vpc_endpoints"></a> [create\_vpc\_endpoints](#input\_create\_vpc\_endpoints) | Whether to create the VPC S3 endpoint configuration. Enabled by default for prod environments | `bool` | `false` | no |
| <a name="input_create_vpc_flow_logs"></a> [create\_vpc\_flow\_logs](#input\_create\_vpc\_flow\_logs) | Whether to create VPC flow log resources. Enabled by default for prod environments | `bool` | `false` | no |
| <a name="input_database_subnet_cidr_blocks"></a> [database\_subnet\_cidr\_blocks](#input\_database\_subnet\_cidr\_blocks) | A list of CIDR blocks to use for database subnets | `list` | `[]` | no |
| <a name="input_database_subnet_name_prefix"></a> [database\_subnet\_name\_prefix](#input\_database\_subnet\_name\_prefix) | Prefix to add to database subnet names | `string` | `"database"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment of the configuration (dev\|prod) | `string` | n/a | yes |
| <a name="input_nat_gateway_per_az"></a> [nat\_gateway\_per\_az](#input\_nat\_gateway\_per\_az) | Whether to create a NAT gateway in each configured AZ. Enabled by default for prod environments | `bool` | `false` | no |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | A list of CIDR blocks to use for private subnets | `list` | `[]` | no |
| <a name="input_private_subnet_name_prefix"></a> [private\_subnet\_name\_prefix](#input\_private\_subnet\_name\_prefix) | Prefix to add to private subnet names | `string` | `"private"` | no |
| <a name="input_public_subnet_cidr_blocks"></a> [public\_subnet\_cidr\_blocks](#input\_public\_subnet\_cidr\_blocks) | A list of CIDR blocks to use for public subnets | `list` | `[]` | no |
| <a name="input_public_subnet_name_prefix"></a> [public\_subnet\_name\_prefix](#input\_public\_subnet\_name\_prefix) | Prefix to add to private subnet names | `string` | `"public"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Whether to create only a single NAT GW in the VPC | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block of the main VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_flow_logs_aggregation_interval"></a> [vpc\_flow\_logs\_aggregation\_interval](#input\_vpc\_flow\_logs\_aggregation\_interval) | The maximum interval of time (in seconds) during which a flow of packets is captured and aggregated into a flow log record | `number` | `600` | no |
| <a name="input_vpc_flow_logs_retention_days"></a> [vpc\_flow\_logs\_retention\_days](#input\_vpc\_flow\_logs\_retention\_days) | Retention (in days) that VPC flow logs are kept | `number` | `30` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the main VPC | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of database subnet CIDR blocks |
| <a name="output_nat_gateway_eips"></a> [nat\_gateway\_eips](#output\_nat\_gateway\_eips) | List of allocated EIPs of NAT gateways |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnet CIDR blocks |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnet CIDR blocks |
<!-- END_TF_DOCS -->