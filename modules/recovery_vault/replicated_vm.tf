# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy

resource "azurerm_site_recovery_replication_policy" "policy" {
  depends_on = [time_sleep.delay_create]
  for_each   = try(var.settings.replicated_vm, {})

  name                                                 = each.value.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.asr.name
  source_recovery_fabric_name                          = azurerm_site_recovery_fabric.recovery_fabric[each.value.source_recovery_fabric_key].name
  source_vm_id                                         = try(var.virtual_machines[var.client_config.landingzone_key][each.value.source_vm_key].id,var.virtual_machines[each.value.source_vm.lz_key][each.value.source_vm.vm_key].id,each.value.source_vm_id)
  recovery_replication_policy_id                       = azurerm_site_recovery_replication_policy.policy[each.value.policy_key].id
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  source_recovery_protection_container_name            = azurerm_site_recovery_protection_container.protection_container[each.value.source_protection_container_key].name
  target_resource_group_id                             = var.resource_groups[each.value.target_resource_group_key].id
  target_recovery_fabric_id                            = azurerm_site_recovery_fabric.recovery_fabric[each.value.target_recovery_fabric_key].id
  target_recovery_protection_container_id              = azurerm_site_recovery_protection_container.protection_container[each.value.target_protection_container_key].id
  target_availability_set_id                           = try(var.availability_sets[var.client_config.landingzone_key][each.value.target_availability_set_key].id, var.availability_sets[each.value.availability_sets].id, null)
  
  dynamic "managed_disk" {
    for_each = try(var.settings.managed_disks)

    content {
      disk_id    =
      staging_storage_account_id = 
      target_resource_group_id =
      target_disk_type = 
      target_replica_disk_type = 
      target_disk_encryption_set_id  =

    }
  }
}