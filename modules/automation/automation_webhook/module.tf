# In some instances, the name of the webhook needs to match the name of workflow, using var.settings.name
#
# resource "azurecaf_name" "automation_webhook" {
#   name          = var.settings.name
#   resource_type = "azurerm_automation_webhook"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_automation_webhook" "automation_webhook" {
  name                    = var.settings.name
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  expiry_time             = var.settings.expiry_time
  enabled                 = try(var.settings.enabled, true)
  runbook_name            = var.settings.runbook_name
  run_on_worker_group     = try(var.settings.run_on_worker_group, null)
  parameters              = try(var.settings.parameters, null)
  uri                     = try(var.settings.uri, null)
}
