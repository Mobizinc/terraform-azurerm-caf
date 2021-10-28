resource "azurerm_notification_hub" "notification_hub" {
  name                = var.settings.name
  namespace_name      = azurerm_notification_hub_namespace.notification_hub_namespace.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.base_tags, try(var.settings.tags, {}))
}