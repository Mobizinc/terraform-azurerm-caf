resource "azurerm_notification_hub_namespace" "notification_hub_namespace" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
  namespace_type      = var.settings.namespace_type
  sku_name            = var.settings.sku_name
  enabled             = try(var.settings.enabled, true)
  tags                = merge(var.base_tags, try(var.settings.tags, {}))
}