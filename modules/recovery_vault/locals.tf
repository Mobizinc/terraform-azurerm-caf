locals {
 virtual_machine_id         = try(var.virtual_machines[var.client_config.landingzone_key][each.value.source_vm_key].id,var.virtual_machines[each.value.source_vm.lz_key][each.value.source_vm.vm_key].id,each.value.source_vm_id)
 virtual_machine_os_disk_id = try(var.virtual_machines[var.client_config.landingzone_key][each.value.source_vm_key].os_disks,var.virtual_machines[each.value.source_vm.lz_key][each.value.source_vm.vm_key].os_disks,each.value.source_vm_os_disk_id)
}