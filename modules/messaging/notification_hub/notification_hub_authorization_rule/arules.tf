resource "azurerm_notification_hub_authorization_rule" "hub_authorization_rule" {
  name                  = var.settings.name
  namespace_name        = var.settings.namespace_name
  notification_hub_name = var.settings.notification_hub_name 
  resource_group_name   = var.resource_group_name
  manage                = try(var.settings.manage, false)
  send                  = try(var.settings.send, false)
  listen                = try(var.settings.listen, false)
}