resource "azurerm_mssql_managed_database" "mssqlmi" {
  depends_on          = [azurerm_mssql_managed_instance.mssqlmi]
  for_each            = try(var.settings.databases, {})
  name                = each.value.name
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
}
