module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = azurerm_mssql_managed_instance.mssqlmi.id
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
