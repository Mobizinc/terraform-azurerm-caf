module "diagnostics" {
  source   = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1
  
  
  resource_id       = azurerm_mssql_managed_instance.mssqlmi.id
  resource_location = azurerm_mssql_managed_instance.mssqlmi.location
  diagnostics       = var.remote_objects.diagnostics
  profiles          = var.settings.diagnostic_profiles
}
