locals {
  public_subnets = { for k, v in var.public_subnets : k => {
    "v4_cidr_blocks": [v],
    "zone": k
  } }
  private_subnets = { for k, v in var.private_subnets : k => {
    "v4_cidr_blocks": [v],
    "zone": k
  }}
}

module "vpc" {
  source = "github.com/terraform-yc-modules/terraform-yc-vpc?ref=1.0.4"

  labels              = { tag = var.prefix_env }
  network_description = "VPC for ${var.prefix_env} environment"
  network_name        = "${var.prefix_env}-vpc"
  create_vpc          = true
  public_subnets      = local.public_subnets
  private_subnets     = local.private_subnets
}