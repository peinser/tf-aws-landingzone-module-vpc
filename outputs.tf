######################################
#	Subnet outputs
######################################

output "private_subnets" {
  description = "List of private subnet CIDR blocks"
  value       = module.vpc[0].private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of public subnet CIDR blocks"
  value       = module.vpc[0].public_subnets_cidr_blocks
}

output "database_subnets" {
  description = "List of database subnet CIDR blocks"
  value       = module.vpc[0].database_subnets_cidr_blocks
}

# ------------------------------------------------------------------------------------


######################################
#	NAT Gateway outputs
######################################

output "nat_gateway_eips" {
  description = "List of allocated EIPs of NAT gateways"
  value       = module.vpc[0].nat_public_ips
}
