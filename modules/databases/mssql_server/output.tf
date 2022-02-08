output "id" {
  value = azurerm_mssql_server.mssql.id
}

output "fully_qualified_domain_name" {
  value = azurerm_mssql_server.mssql.fully_qualified_domain_name
}

output "rbac_id" {
  value = try(azurerm_mssql_server.mssql.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_mssql_server.mssql.identity, null)
}

output "azuread_administrator" {
  value = try(azurerm_mssql_server.mssql.azuread_administrator, null)
}

output "name" {
  value = azurecaf_name.mssql.result
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}

output "administrator_login_password" {
  value = try(azurerm_mssql_server.mssql.administrator_login_password, null)
}

output "administrator_login" {
  value = try(azurerm_mssql_server.mssql.administrator_login, null)
}
