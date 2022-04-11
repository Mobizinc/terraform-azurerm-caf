resource "azurerm_management_group" "groups" {
  display_name               = var.settings.display_name
  parent_management_group_id = try(var.settings.parent_management_groups_key,null) != null ? format("/providers/Microsoft.Management/managementGroups/%s", var.settings.parent_management_groups_key) : null
  subscription_ids           = try(var.settings.subscription_ids, null)
  name                       = var.settings.display_name

  # provisioner "local-exec" {
  #   command     = "/tf/caf/aztfmod/modules/management_groups/scripts/create_check.sh ${var.settings.display_name}"
  # }
#   provisioner "local-exec" {
#     command     = format("%s/scripts/delete_check.sh ${var.group_id}", path.module)
#     interpreter = ["/bin/bash"]
#     when        = destroy
# }

}

resource "time_sleep" "after_azurerm_management_group" {
  depends_on = [
    azurerm_management_group.groups
  ]

  triggers = {
    "azurerm_management_group" = jsonencode(keys(azurerm_management_group.groups))
  }

  create_duration  = "60s"
  destroy_duration = "60s"
}
