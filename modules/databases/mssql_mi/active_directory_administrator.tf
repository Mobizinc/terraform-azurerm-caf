resource "azurerm_mssql_managed_instance_active_directory_administrator" "mssqlmi_active_directory_administrator" {
  depends_on = [azurerm_mssql_managed_instance.mssqlmi]
  for_each =  try(var.active_directory_administrator, {})
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
  login_username      = try(var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].name, var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].name)
  object_id           = try(var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].id, var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].id)
  tenant_id           = try(var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].tenant_id, var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].tenant_id)
  azuread_authentication_only = try(each.value.azuread_authentication_only , false)
}
