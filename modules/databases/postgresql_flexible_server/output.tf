output "id" {
  value = azurerm_postgresql_flexible_server.postgresql.id
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgresql.fqdn
}



output "name" {
  value = azurerm_postgresql_flexible_server.postgresql.name
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
