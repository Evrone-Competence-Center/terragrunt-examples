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
  type        = map(any)
  description = "Bucket names with bucket options"
  default = {}
}