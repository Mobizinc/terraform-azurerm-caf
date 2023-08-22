output "location" {
  description = "Azure Region where the resource exists"
  value       = var.location
}

output "postgresql_flexible_server_id" {
  description = "ID of the PostgreSQL flexible server"
  value       = azapi_resource.postgres_flexible_server.id
}

output "postgresql_flexible_server_name" {
  description = "Name of the PostgreSQL flexible server"
  value       = azapi_resource.postgres_flexible_server.name
}

output "postgresql_flexible_server_configuration_id" {
  description = "ID of the PostgreSQL flexible server configuration"
  value = {
    for k, v in azurerm_postgresql_flexible_server_configuration.postgresql : k => v.id
  }
}

output "postgresql_flexible_server_database_id" {
  description = "ID of the PostgreSQL flexible server database"
  value = {
    for k, v in azurerm_postgresql_flexible_server_database.postgresql : k => v.id
  }
}

output "postgresql_flexible_server_firewall_rule_id" {
  description = "ID of the PostgreSQL flexible server firewall rule"
  value = {
    for k, v in azurerm_postgresql_flexible_server_firewall_rule.postgresql : k => v.id
  }
}

output "resource_group_name" {
  description = "Name of the Resource Group where the resource exists."
  value       = var.resource_group_name
}
