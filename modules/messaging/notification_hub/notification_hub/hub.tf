resource "azurerm_notification_hub" "notification_hub" {
  name                = var.settings.name
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.base_tags, try(var.settings.tags, {}))
}