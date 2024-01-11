terraform {
  source = "${find_in_parent_folders("modules/s3")}///"
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

  buckets_raw = lookup(local.env_vars, "s3", {})
  buckets = merge(
    { for k, v in local.buckets_raw : k => {} },
    { for k, v in local.buckets_raw : k => v if v != null }, 
    {}
  )
}

inputs = {
  env        = local.env_vars.env
  prefix_env = local.env_vars.env

  # module variables
  buckets = local.buckets
}