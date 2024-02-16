module "databricks_access_connectors" {
  source   = "./modules/analytics/databricks_access_connector"
  for_each = local.database.databricks_access_connectors

  client_config     = local.client_config
  global_settings   = local.global_settings
  name              = each.value.name
  settings          = each.value
  resource_groups   = local.combined_objects_resource_groups
  base_tags         = local.global_settings.inherit_tags
  resource_group    = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key).name]
  location          = try(local.global_settings.regions[each.value.region], null)
  identity                            = try(each.value.identity, null) 
}

output "databricks_access_connectors" {
  value = module.databricks_access_connectors

}
