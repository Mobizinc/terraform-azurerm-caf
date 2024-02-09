variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  description = "(Required) Name of the App Service"
}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the App Service"
}

variable "app_service_plan_id" {
}

variable "identity" {
  default = null
}

variable "connection_strings" {
  default = {}
}

variable "app_settings" {
  default = null
}


variable "application_insight" {
  default = null
}

variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "combined_objects" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}

variable "diagnostic_profiles" {
  default = null
}
variable "diagnostics" {
  default = null
}

variable "remote_objects" {
  default = {}
}

variable "keyvault_name" {
  default = {}
}

variable "publish_profile" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "app_service_name" {
  default = {}
}
variable "vnet_integration" {
  default = {}
}
variable "app_services" {
  default = {}
}
