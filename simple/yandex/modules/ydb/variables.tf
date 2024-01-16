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

variable "ydb_database_serverless" {
  description = <<EOF
    Serverless Yandex Database.

    Configuration attributes:
      - name       - (Required) Name of the database.
      - description         - (Optional) Description of the database.
      - labels              - (Optional) A set of key/value label pairs to assign to the database.
      - deletion_protection - (Optional) If set, it prevents Terraform from deleting the database.
      - serverless_database - (Optional) Serverless Yandex Database settings.
        - throttling_rcu_limit        - (Optional) Throttling RCU limit.
        - storage_size_limit          - (Optional) Storage size limit.
        - enable_throttling_rcu_limit - (Optional) Enable throttling RCU limit.
        - provisioned_rcu_limit       - (Optional) Provisioned RCU limit.
  EOF
  type = object({
    name                = optional(string)
    name_prefix         = optional(string)
    description         = optional(string)
    labels              = optional(map(string))
    deletion_protection = optional(bool, false)
    serverless_database = optional(object({
      throttling_rcu_limit        = optional(number)
      storage_size_limit          = optional(number)
      enable_throttling_rcu_limit = optional(bool, false)
      provisioned_rcu_limit       = optional(number)
    }))
  })
}

variable "ydb_database_tables" {
  type = list(object({
    path = string
    columns = optional(list(object({
      name = string
      type = optional(string, "Utf8")
      not_null = optional(bool, false)
    })), [])
    primary_key = optional(list(string), [])
    ttl = optional(object({
      column_name = string
      expire_interval = string
    }))
    partitioning_settings = optional(object({
      partitioning_enabled = bool
      partitioning_ttl = optional(object({
        auto_partitioning_by_load = optional(bool)
        auto_partitioning_partition_size_mb = optional(number)
        auto_partitioning_min_partitions_count = optional(number)
        auto_partitioning_max_partitions_count = optional(number)
      }))
    }))

    # TODO: read_replicas_settings

    key_bloom_filter = optional(bool)

    # TODO: lifecycle

    # TODO: yandex_ydb_table_index
    # TODO  yandex_ydb_table_changefeed
  }))
  default = []
}