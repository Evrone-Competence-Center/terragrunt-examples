variable "prefix_env" {
  description = "Prefix Environment"
  type        = string
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = map(string)
  default = {
    ru-central1-a = "10.121.0.0/16"
    ru-central1-b = "10.131.0.0/16"
    ru-central1-c = "10.141.0.0/16"
  }
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = map(string)
  default = {
    ru-central1-a = "10.221.0.0/16"
    ru-central1-b = "10.231.0.0/16"
    ru-central1-c = "10.241.0.0/16"
  }
}