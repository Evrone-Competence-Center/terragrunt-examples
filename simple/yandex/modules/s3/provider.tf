# Just fake AWS provider, its needed by terraform-yc-s3
provider "aws" {
  region                      = "us-east-1"
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}