locals {
  env_content = try(yamldecode(file("${get_env("TENANT", "dev")}/env.yaml")), {})
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket           = lookup(local.env_content.s3, "bucket", "bucket-for-example-tf-state")
    key              = "${path_relative_to_include()}/terraform.tfstate"
    endpoint         = "https://storage.yandexcloud.net"
    region           = "ru-cetnral1"
    force_path_style = true


    skip_credentials_validation = true
    skip_region_validation      = true
    skip_bucket_ssencryption    = true
    skip_metadata_api_check     = true
    skip_bucket_root_access     = true

    # To Disable update Bucket (raised access error for yandex block storage)
    disable_bucket_update       = true
  }
}