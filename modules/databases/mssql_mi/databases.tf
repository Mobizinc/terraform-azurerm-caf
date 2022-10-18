resource "azurerm_mssql_managed_database" "mssqlmi" {
  depends_on          = [azurerm_mssql_managed_instance.mssqlmi]
  for_each            = try(var.settings.databases, {})
  name                = each.value.name
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
}

resource "azurerm_resource_group_template_deployment" "backupltr" {
  for_each            = try(var.settings.databases, {})
  
  name                = each.value.name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content  = jsonencode({
  
    "serverName"       = { value = azurerm_mssql_managed_instance.mssqlmi.name }
    "dbName"           = { value = each.value.name }
    "retentionDays"    = { value = each.value.retentionDays }
  })
  template_content     = file(local.arm_filename)
}
