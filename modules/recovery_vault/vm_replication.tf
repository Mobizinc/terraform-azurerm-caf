#TO DO

#resource "azurerm_site_recovery_replicated_vm" "vm-replication" {
#  for_each = try(var.settings.vm-replication, {})
#  name                                      = each.value.name
#  resource_group_name                       = var.resource_group_name
#  recovery_vault_name                       = azurerm_recovery_services_vault.asr.name
#  source_recovery_fabric_name               = azurerm_site_recovery_fabric.recovery_fabric[each.value.source_recovery_fabric_key].name
#  source_vm_id                              = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].id, null) : try(azurerm_windows_virtual_machine.vm["windows"].id, null)

### NEED TO UPDATE THIS TO REPLICATION POLICIES. COPIED FROM BACKUP POLICY ID
#  recovery_replication_policy_id            = coalesce(
#    try(var.settings.backup.backup_policy_id, null),
#    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.backup.vault_key].backup_policies.virtual_machines[var.settings.backup.policy_key].id, null),
#    try(var.recovery_vaults[var.settings.backup.lz_key][var.settings.backup.vault_key].backup_policies.virtual_machines[var.settings.backup.policy_key].id, null)
#  )


#  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.protection_container[each.value.source_protection_container_key].name
#
#  target_resource_group_id                = var.resource_group_name
#  target_recovery_fabric_id               = azurerm_site_recovery_fabric.recovery_fabric[each.value.target_recovery_fabric_key].name
#  target_recovery_protection_container_id = azurerm_site_recovery_protection_container.protection_container[each.value.target_protection_container_key].id
#
#  managed_disk {
#    disk_id                    = azurerm_virtual_machine.vm.storage_os_disk[0].managed_disk_id
#    staging_storage_account_id = azurerm_storage_account.primary.id
#    target_resource_group_id   = var.resource_group_name
#    target_disk_type           = each.value.target_disk_type
#    target_replica_disk_type   = each.value.target_replica_disk_type
#  }
#
#  network_interface {
#    source_network_interface_id   = var.existing_resources.virtual_machines[each.value.vm_key].nics[each.value.nic_key].id
#    target_subnet_name            = "network2-subnet"
#    recovery_public_ip_address_id = azurerm_public_ip.secondary.id
#  }
#}