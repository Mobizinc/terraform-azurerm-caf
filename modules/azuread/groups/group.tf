resource "azuread_group" "group" {

  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), var.azuread_groups.name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)
  owners = coalescelist(
    try(tolist(var.azuread_groups.owners), []),
    [
      var.client_config.object_id
    ]
  )
}

resource "null_resource" "list_aad_groups" {
  depends_on = [azuread_group.group]

  triggers = {
    aad_group_id = lookup(azuread_group.group.outputs, "id")
  }

  provisioner "local-exec" {
    when    = create
    command     = format("%s/scripts/list_created_aad_group.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail
    environment = {
     aad_group_name = azuread_group.group.outputs.name
     aad_group_id   = azuread_group.group.outputs.id
    }
  }
}
