resource "azurerm_databricks_access_connector" "databricks_access_connector" {
  name                = var.name
  resource_group_name = local.resource_group.name
  location            = var.location
  tags                = local.tags

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = concat(local.managed_identities, try(identity.value.identity_ids, []))
    }
  }
  
}

