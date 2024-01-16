terraform {
  source = "${find_in_parent_folders("modules/ydb")}///"
}

prevent_destroy = false

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  env_module_content = try(yamldecode(file("./env.yaml")), {})
  env_content        = try(yamldecode(file("../env.yaml")), {})
  env_vars = merge(
    include.root.locals,     # root variables
    local.env_content,       # overrides with tenant(env) variables
    local.env_module_content # overrides with module variables
  )
}

inputs = {
  env        = local.env_vars.env
  prefix_env = local.env_vars.env

  # current module variables (inputs)
  # different depending on the module

  ydb_database_serverless = try(local.env_vars.ydb_database_serverless, null)
  ydb_database_tables = try(local.env_vars.tables, [])
  // ...
  // public_subnets = try(local.env_vars.public_subnets, {})
  // ...
}