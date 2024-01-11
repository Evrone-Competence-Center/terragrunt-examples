# Global variables
variable "env" {
  type        = string
  description = "Environment name"
}

variable "prefix_env" {
  type        = string
  description = "Prefix environment name"
}

# Current module variables

variable "buckets" {
  type = map(object({
    // Types from Yandex s3 module
    storage_admin_service_account = optional(object({
      name                        = optional(string)
      name_prefix                 = optional(string)
      description                 = optional(string)
      existing_account_id         = optional(string)
      existing_account_access_key = optional(string)
      existing_account_secret_key = optional(string)
    }))

    force_destroy = optional(bool)

    acl = optional(string)

    grant = optional(list(object({
      id          = optional(string)
      type        = string
      uri         = optional(string)
      permissions = set(string)
    })))

    policy = optional(object({
      enabled = bool
      statements = optional(list(object({
        sid       = optional(string)
        effect    = optional(string)
        actions   = list(string)
        resources = list(string)
        principal = optional(object({
          type        = string
          identifiers = list(string)
        }))
        not_principal = optional(object({
          type        = string
          identifiers = list(string)
        }))
        condition = optional(object({
          type   = string
          key    = string
          values = list(any)
        }))
      })))
    }))

    policy_console = optional(object({
      enabled = bool
      sid     = optional(string)
      effect  = optional(string)
      principal = optional(object({
        type        = string
        identifiers = list(string)
      }))
      not_principal = optional(object({
        type        = string
        identifiers = list(string)
      }))
    }))

    cors_rule = optional(list(object({
      allowed_headers = optional(set(string))
      allowed_methods = set(string)
      allowed_origins = set(string)
      expose_headers  = optional(set(string))
      max_age_seconds = optional(number)
    })))

    website = optional(object({
      index_document = optional(string)
      error_document = optional(string)
      routing_rules = optional(list(object({
        condition = optional(object({
          key_prefix_equals               = optional(string)
          http_error_code_returned_equals = optional(string)
        }))
        redirect = object({
          protocol                = optional(string)
          host_name               = optional(string)
          replace_key_prefix_with = optional(string)
          replace_key_with        = optional(string)
          http_redirect_code      = optional(string)
        })
      })))
      redirect_all_requests_to = optional(string)
    }))

    versioning = optional(object({ enabled = bool }))

    object_lock_configuration = optional(object({
      object_lock_enabled = optional(string)
      rule = optional(object({
        default_retention = object({
          mode  = string
          days  = optional(number)
          years = optional(number)
        })
      }))
    }))

    logging = optional(object({
      target_bucket = string
      target_prefix = optional(string)
    }))

    lifecycle_rule = optional(list(object({
      enabled                                = bool
      id                                     = optional(string)
      prefix                                 = optional(string)
      abort_incomplete_multipart_upload_days = optional(number)
      expiration = optional(object({
        date                         = optional(string)
        days                         = optional(number)
        expired_object_delete_marker = optional(bool)
      }))
      transition = optional(object({
        date          = optional(string)
        days          = optional(number)
        storage_class = string
      }))
      noncurrent_version_expiration = optional(object({
        days = number
      }))
      noncurrent_version_transition = optional(object({
        days          = number
        storage_class = string
      }))
    })))

    server_side_encryption_configuration = optional(object({
      enabled           = bool
      sse_algorithm     = optional(string)
      kms_master_key_id = optional(string)
    }))

    sse_kms_key_configuration = optional(object({
      name                = optional(string)
      name_prefix         = optional(string)
      description         = optional(string, "KMS key for Object storage server-side encryption.")
      default_algorithm   = optional(string, "AES_256")
      rotation_period     = optional(string, "8760h")
      deletion_protection = optional(bool, false)
    }))

    tags = optional(map(string))

    folder_id = optional(string)

    max_size = optional(number)

    default_storage_class = optional(string, "STANDARD")

    anonymous_access_flags = optional(object({
      list        = optional(bool)
      read        = optional(bool)
      config_read = optional(bool)
    }))

    https = optional(object({
      existing_certificate_id = optional(string)
      certificate = optional(object({
        domains             = set(string)
        public_dns_zone_id  = string
        dns_records_ttl     = optional(number, 300)
        name                = optional(string)
        name_prefix         = optional(string)
        description         = optional(string, "Certificate for S3 static website.")
        labels              = optional(map(string))
        deletion_protection = optional(bool, false)
      }))
    }))
    // End of types declaration
  }))
  description = "Bucket names with bucket options"
  default     = {}
}