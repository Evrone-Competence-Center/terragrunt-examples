locals {
  buckets = var.buckets
}

module "s3" {
  for_each = local.buckets
  source = "github.com/terraform-yc-modules/terraform-yc-s3?ref=0ed1dddf81adc20055891e9f94233f0c6c8aec7c"

  bucket_name = each.key
}
