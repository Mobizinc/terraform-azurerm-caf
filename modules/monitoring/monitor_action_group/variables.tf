variable "global_settings" {
  description = "Global settings object"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Action Group instance"
  type        = string
}

variable "settings" {
  description = "Configuration object for the monitor action group"
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "combined_objects_automations" {}
variable "combined_objects_automation_runbooks" {}
variable "combined_objects_automation_webhooks" {}
