resource "azurerm_security_center_workspace" "workspace" {
  scope        = coalesce(
      try(format("/subscriptions/%s", var.subscriptions[try(var.settings.scopes.subscription.lz_key, var.client_config)][var.settings.scopes.subscription.key].id), ""),
      try(var.settings.scopes.subscription.id, ""))
  workspace_id = var.workspace_id
}