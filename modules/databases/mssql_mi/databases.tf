resource "azurerm_mssql_managed_database" "mssqlmi" {
  depends_on          = [azurerm_mssql_managed_instance.mssqlmi]
  for_each            = try(var.settings.databases, {})
  name                = each.value.name
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
}

resource "null_resource" "retentiondays" {
    depends_on          = [azurerm_mssql_managed_database.mssqlmi]
    for_each    =        var.retentiondays
    triggers = {
    retentiondays  =  each.value.retentiondays  
  }
    provisioner "local-exec" {
         
         command = <<-EOT
           az sql midb short-term-retention-policy set -g $resource_group --mi $servername -n $dbname --retention-days $retentiondays
         EOT

         environment = {
          resource_group =  var.resource_group_name
          dbname         =  each.value.dbname
          retentiondays  =  self.triggers.retentiondays
          servername     =  azurerm_mssql_managed_instance.mssqlmi.name
         
    }
    }
}

resource "null_resource" "ltr_policy" {
    depends_on          = [azurerm_mssql_managed_database.mssqlmi]
    for_each    =        var.ltr_policy
    triggers = {
          weekly_retention  =  each.value.weekly_retention
          monthly_retention =  each.value.monthly_retention
          yearly_retention  =  each.value.yearly_retention
          week_of_year      =  each.value.week_of_year
    }
    provisioner "local-exec" {
         
         command = <<-EOT
           az sql midb ltr-policy set -g $resource_group --mi $servername -n $dbname --weekly-retention $weekly_retention --monthly-retention $monthly_retention --yearly-retention $yearly_retention --week-of-year $week_of_year
         
         EOT

         environment = {
          resource_group    =  var.resource_group_name
          dbname            =  each.value.dbname
          weekly_retention  =  self.triggers.weekly_retention
          monthly_retention =  self.triggers.monthly_retention
          yearly_retention  =  self.triggers.yearly_retention
          week_of_year      =  self.triggers.week_of_year
          servername        =  azurerm_mssql_managed_instance.mssqlmi.name
         
    }
    }
}
