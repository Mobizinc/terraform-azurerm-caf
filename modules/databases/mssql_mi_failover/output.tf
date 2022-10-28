output "name" {
  value       = azurecaf_name.mssqlmi_failover.result
  description = "SQL MI Failover Group Name"
}

output "id" {
  value       = azurerm_mssql_managed_instance_failover_group.mssqlmi_failover.id
  description = "SQL MI Failover Group Id"
}

output "location" {
  value = var.location
}