
resource "azurerm_static_site" "static_site" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_tier            = try(var.settings.sku_tier, null)
  sku_size            = try(var.settings.sku_size,  null)
  tags                = local.tags


  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

}


resource "null_resource" "static_webapps_github_public" {
  count      = var.settings.github_private != "yes" ? 1 : 0
  provisioner "local-exec" {
    command = format("az staticwebapp update --name %s  --source %s --branch %s " ,  var.name , var.settings.github_source , var.settings.github_branch  )
      
    
  }
    depends_on = [
    azurerm_static_site.static_site
  ]
}

resource "null_resource" "static_webapps_github_private" {
  count      = var.settings.github_private == "yes" ? 1 : 0
  provisioner "local-exec" {
    command = format("az staticwebapp update --name %s  --source %s --branch %s  --token %s " ,  var.name , var.settings.github_source , var.settings.github_branch , var.settings.github_token )
      
    
  }
    depends_on = [
    azurerm_static_site.static_site
  ]
}