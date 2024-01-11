locals {
  buckets = var.buckets
}

module "s3" {
  for_each = local.buckets
  source   = "github.com/terraform-yc-modules/terraform-yc-s3?ref=0ed1dddf81adc20055891e9f94233f0c6c8aec7c"

  bucket_name                          = each.key
  storage_admin_service_account        = lookup(each.value, "storage_admin_service_account", {})
  force_destroy                        = lookup(each.value, "force_destroy", false)
  acl                                  = lookup(each.value, "acl", null)
  grant                                = lookup(each.value, "grant", [])
  policy                               = lookup(each.value, "policy", { enabled = false })
  policy_console                       = lookup(each.value, "policy_console", { enabled = false })
  cors_rule                            = lookup(each.value, "cors_rule", [])
  website                              = lookup(each.value, "website", { default = null })
  versioning                           = lookup(each.value, "versioning", null)
  object_lock_configuration            = lookup(each.value, "object_lock_configuration", null)
  logging                              = lookup(each.value, "logging", null)
  lifecycle_rule                       = lookup(each.value, "lifecycle_rule", [])
  server_side_encryption_configuration = lookup(each.value, "server_side_encryption_configuration", { enabled = false })
  sse_kms_key_configuration            = lookup(each.value, "sse_kms_key_configuration", {})
  tags                                 = lookup(each.value, "tags", {})
  folder_id                            = lookup(each.value, "folder_id", null)
  max_size                             = lookup(each.value, "max_size", null)
  default_storage_class                = lookup(each.value, "default_storage_class", "STANDARD")
  anonymous_access_flags               = lookup(each.value, "anonymous_access_flags", null)
  https                                = lookup(each.value, "https", null)
}
