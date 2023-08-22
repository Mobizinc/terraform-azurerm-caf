data "azurerm_client_config" "current" {
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "sql_mi_active_directory_administrator" {
  depends_on = [azurerm_mssql_managed_instance.mssqlmi]
  for_each =  var.active_directory_administrator
  lifecycle {
    ignore_changes = [managed_instance_id]
  }

  managed_instance_id         = azurerm_mssql_managed_instance.mssqlmi.id  
  azuread_authentication_only = try(each.value.azuread_authentication_only , false)
  login_username = try(each.value.login_username, try(var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].name, var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].name))
  object_id      = try(each.value.object_id, try(var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].id, var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].id))
  tenant_id      = try(each.value.tenant_id, data.azurerm_client_config.current.tenant_id)
}
