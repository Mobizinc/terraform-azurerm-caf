resource "azurerm_mssql_managed_database" "mssqlmi" {
  depends_on          = [azurerm_mssql_managed_instance.mssqlmi]
  for_each            = try(var.settings.databases, {})
  name                = each.value.name
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
}

resource "null_resource" "retentiondays" {
    depends_on          = [azurerm_mssql_managed_database.mssqlmi]
    for_each            = try(var.settings.retentiondays, {})
   
    provisioner "local-exec" {
         
         command = <<-EOT
           az sql midb short-term-retention-policy set -g $resource_group --mi $servername -n $dbname --retention-days $retentiondays
         EOT

         environment = {
          resource_group =  var.resource_group_name
          dbname         =  each.value.dbname
          retentiondays  =  each.value.retentiondays
          servername     =  each.value.azurerm_mssql_managed_instance.mssqlmi.name
         
    }
    }
}
