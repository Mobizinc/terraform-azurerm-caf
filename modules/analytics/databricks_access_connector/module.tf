resource "azurerm_databricks_access_connector" "databricks_access_connector" {
  name                = var.name
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }
  
}

