variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}

variable "redis" {}

variable "subnet_id" {
  description = "The ID of the Subnet within which the Redis Cache should be deployed"
  type        = string
  default     = null
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "diagnostic_profiles" {
  default = null
}

variable "diagnostics" {
  default = null
}

variable "remote_objects" {
  default = null
}

variable "client_config" {}

variable "resource_groups" {
  description = "combined objetcs of the resource groups. Either resource_group_name or resource_groups is required."
  default     = {}
}
