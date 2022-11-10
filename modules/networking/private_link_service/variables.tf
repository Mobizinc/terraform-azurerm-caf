variable "name" {
  type        = string
  description = "(Required) Specifies the name. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "The name of the resource group. Changing this forces a new resource to be created."
  default     = null
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "subnet_id" {}
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "auto_approval_subscription_ids" {
  default = []
}
variable "load_balancer_frontend_ip_configuration_ids" {
  default = []
}
variable "enable_proxy_protocol" {
  default = null
}
variable "fqdns" {
  default = null
}
variable "visibility_subscription_ids" {
  default = []
}
variable "client_config" {
  default = {}
}
variable "networking" {
  default = {}
}