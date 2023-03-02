
resource "azapi_resource" "private_dns_resolvers" {
  type      = "Microsoft.Network/dnsResolvers@2022-07-01"
  name      = var.settings.name
  location  = var.location
  parent_id = var.resource_group_name
  tags      = merge(local.tags, lookup(var.settings, "tags", {}))

  body = jsonencode({
    properties = {
      virtualNetwork = {
        id = try(var.remote_objects.vnet_id, var.settings.vnet_id)
      }
    }
  })
  response_export_values = ["properties.virtualNetwork.id"]
}

resource "azapi_resource" "inbound_endpoint" {
  for_each   = var.inbound_endpoint
  type       = "Microsoft.Network/dnsResolvers/inboundEndpoints@2022-07-01"
  name       = each.value.name
  location   = azapi_resource.private_dns_resolvers.location
  parent_id  = azapi_resource.private_dns_resolvers.id
  tags       = merge(local.tags, lookup(var.settings, "tags", {}))

  body = jsonencode({
    properties = {
      ipConfigurations = [
        {
          privateIpAddress          = try(each.value.privateipaddress, null)
          privateIpAllocationMethod = try(each.value.privateipallocationmethod, null)
          subnet = {
            id = try(
              var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id,
              var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id,
              each.value.subnet_id,
              null
              )
          }
        }
      ]
    }
  })
  response_export_values = ["properties.ipconfiguration"]
  depends_on = [
    azapi_resource.private_dns_resolvers
  ]
}

resource "azapi_resource" "outbound_endpoint" {
  for_each   = var.outbound_endpoint
  type       = "Microsoft.Network/dnsResolvers/outboundEndpoints@2022-07-01"
  name       = each.value.name
  location   = azapi_resource.private_dns_resolvers.location
  parent_id  = azapi_resource.private_dns_resolvers.id
  tags       = merge(local.tags, lookup(var.settings, "tags", {}))

  body = jsonencode({
    properties = {
      subnet = {
        id = try(
          var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id,
          var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id,
          each.value.subnet_id,
          null
        )
      }
    }
  })

  response_export_values = ["properties.subnet"]
  depends_on = [
    azapi_resource.private_dns_resolvers
  ]
}