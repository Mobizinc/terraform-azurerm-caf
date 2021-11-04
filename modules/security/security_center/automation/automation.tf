# resource "azurecaf_name" "caf_name_automation" {

#   name          = var.name
#   resource_type = "azurerm_security_center_automation"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_security_center_automation" "automation" {
  name                = var.name #azurecaf_name.caf_name_automation.result
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "action" {
    for_each = try(var.settings.action, {})
    content {
    type              = action.value.type
    resource_id       = action.value.type == "EventHub" ? var.event_hub_namespaces[try(var.settings.lz_key, var.client_config)][action.value.resource_id].id : (action.value.type == "LogicApp" ? var.logic_app_workflow[try(var.settings.lz_key, var.client_config)][action.value.resource_id].id : var.log_analytics[try(var.settings.lz_key, var.client_config)][action.value.resource_id].id)
    connection_string = action.value.type == "EventHub" ? var.event_hub_namespaces[try(var.settings.lz_key, var.client_config)][action.value.resource_id].connection_string : null
    trigger_url       = action.value.type == "LogicApp" ? try(var.trigger_url[try(var.settings.lz_key, var.client_config)][action.value.resource_id].callback_url, null) : null
    }
  }

  dynamic "source" {
    for_each = try(var.settings.source.rule_set, {})
    content {
      event_source   = var.settings.source.event_source
      rule_set {
        rule {
          property_path  = source.value.property_path
          operator       = source.value.operator
          expected_value = source.value.expected_value
          property_type  = source.value.property_type
        }
      }
    }
  }
  scopes = [coalesce(
      try(format("/subscriptions/%s", var.subscriptions[try(var.settings.scopes.subscription.lz_key, var.client_config)][var.settings.scopes.subscription.key].id), ""),
    try(var.settings.scopes.subscription.id, ""))]
}