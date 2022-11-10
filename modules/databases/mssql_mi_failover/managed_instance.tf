resource "azurecaf_name" "mssqlmi_failover" {
  name          = var.settings.name
  resource_type = "azurerm_mssql_mi" 
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_managed_instance_failover_group" "mssqlmi_failover" {
  name                        = azurecaf_name.mssqlmi_failover.result
  #resource_group_name         = var.resource_group_name
  location                    = var.location
  managed_instance_id         = var.primary_server_id
  partner_managed_instance_id = var.secondary_server_id

  readonly_endpoint_failover_policy_enabled = try(var.settings.readonly_endpoint_failover_policy_enabled , false)
  
  dynamic "read_write_endpoint_failover_policy" {
    for_each = lookup(var.settings, "read_write_endpoint_failover_policy", {}) != {} ? [1] : []
  
    content {
      mode          = lookup(var.settings.read_write_endpoint_failover_policy, "mode", false)
      grace_minutes = lookup(var.settings.read_write_endpoint_failover_policy, "grace_minutes", null)
    }
  }
}