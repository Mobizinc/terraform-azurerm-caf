variable "settings" {}

variable "global_settings" {}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the App Service"
  default     = null
}

variable "app_service_plan_id" {
}
variable "resource_groups" {
  description = "combined objetcs of the resource groups. Either resource_group_name or resource_groups is required."
  default     = {}
}
variable "tags" {
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  description = "(Required) Name of the App Service"
}


variable "storage_account_access_key" {
  default = null
}

variable "storage_account_name" {
  default = null
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

variable "slots" {
  default = {}
}

variable "application_insight" {
  default = null
}

variable "base_tags" {}

variable "combined_objects" {
  default = {}
}

variable "client_config" {}

variable "dynamic_app_settings" {
  default = {}
}

variable "remote_objects" {
  default = null
}
