module "ydb" {
  # source = "../../../../../../../../../yc-modules/terraform-yc-ydb"
  source = "github.com/org/repo" # TODO: Change to real module source

  ydb_database_serverless = try(var.ydb_database_serverless, null)
  ydb_database_tables = try(var.ydb_database_tables, [])
}