output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private Subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public Subnets"
  value       = module.vpc.public_subnets
}