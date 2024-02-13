resource "azurecaf_name" "logic_app_standard_name" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_workflow"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_logic_app_standard" "logic_app" {
  #To avoid redeploy with existing customer
  lifecycle {
    ignore_changes = [] #[name, storage_account_name]
  }
  name                       = azurecaf_name.logic_app_standard_name.result #try(var.name, "logicappRanDomString") azurecaf_name.plan.result
  location                   = lookup(var.settings, "region", null) == null ? local.resource_group.location : var.global_settings.regions[var.settings.region]
  resource_group_name        = local.resource_group.name
  app_service_plan_id        = local.app_service_plan.id
  use_extension_bundle       = try(var.settings.use_extension_bundle, null)
  bundle_version             = try(var.settings.bundle_version, null)
  client_affinity_enabled    = lookup(var.settings, "client_affinity_enabled", null)
  client_certificate_mode    = try(var.settings.client_certificate_mode, null)
  enabled                    = try(var.settings.enabled, null)
  https_only                 = try(var.settings.https_only, null)
  version                    = try(var.settings.version, null)
  storage_account_name       = local.storage_account.name
  storage_account_access_key = local.storage_account.primary_access_key
  storage_account_share_name = try(var.settings.storage_account_share_name, null)
  tags                       = local.tags

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      #identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                        = lookup(var.settings.site_config, "always_on", false)
      app_scale_limit                  = lookup(var.settings.site_config, "app_scale_limit", null)
      elastic_instance_minimum         = lookup(var.settings.site_config, "elastic_instance_minimum", null)
      health_check_path                = lookup(var.settings.site_config, "health_check_path", null)
      min_tls_version                  = lookup(var.settings.site_config, "min_tls_version", null)
      pre_warmed_instance_count        = lookup(var.settings.site_config, "pre_warmed_instance_count", null)
      runtime_scale_monitoring_enabled = lookup(var.settings.site_config, "runtime_scale_monitoring_enabled", null)
      dotnet_framework_version         = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                       = lookup(var.settings.site_config, "ftps_state", null)
      http2_enabled                    = lookup(var.settings.site_config, "http2_enabled", null)
      linux_fx_version                 = lookup(var.settings.site_config, "linux_fx_version", null)
      use_32_bit_worker_process        = lookup(var.settings.site_config, "use_32_bit_worker_process", null)
      websockets_enabled               = lookup(var.settings.site_config, "websockets_enabled", null)
      vnet_route_all_enabled           = lookup(var.settings.site_config, "vnet_route_all_enabled", null)

      dynamic "cors" {
        for_each = try(var.settings.site_config.cors, {})

        content {
          allowed_origins     = lookup(cors, "allowed_origins", null)
          support_credentials = lookup(cors, "support_credentials", null)
        }
      }

      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})

        content {
          ip_address                = lookup(ip_restriction, "ip_address", null)
          service_tag               = lookup(ip_restriction, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction, "virtual_network_subnet_id", null)
          name                      = lookup(ip_restriction, "name", null)
          priority                  = lookup(ip_restriction, "priority", null)
          action                    = lookup(ip_restriction, "action", null)
          dynamic "headers" {
            for_each = try(ip_restriction.headers, {})

            content {
              x_azure_fdid      = lookup(headers, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers, "x_forwarded_host", null)
            }
          }
        }
      }
    }
  }

}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on = [azurerm_logic_app_standard.logic_app]
  count      = lookup(var.settings, "vnet_integration", {}) != {} ? 1 : 0

  app_service_id = azurerm_logic_app_standard.logic_app.id
  subnet_id = can(var.vnet_integration.subnet_id) ? var.vnet_integration.subnet_id : try(var.vnets[try(var.vnet_integration.lz_key, var.client_config.landingzone_key)][var.vnet_integration.vnet_key].subnets[var.vnet_integration.subnet_key].id,
  try(var.virtual_subnets[var.client_config.landingzone_key][var.vnet_integration.subnet_key].id, var.virtual_subnets[var.vnet_integration.lz_key][var.vnet_integration.subnet_key].id))

}

resource "time_sleep" "wait_for_logic_app" {
  depends_on = [azurerm_logic_app_standard.logic_app]

  create_duration = "60s"
}

resource "null_resource" "logicapp_api_permission_dev1" {
  depends_on = [time_sleep.wait_for_logic_app]
  count      = try(var.settings.name, null) == "iam-automation-nonprod-dev" ? 1 : 0     #var.name == "iam-automation-nonprod-dev" ? 1 : 0

  provisioner "local-exec" {
    command     = format("%s/scripts/api_permission_dev.sh", path.module)
    interpreter = ["/bin/bash"]
  }
}

resource "null_resource" "logicapp_api_permission_uat" {
  depends_on = [time_sleep.wait_for_logic_app]
  count      = try(var.settings.name, null) == "iam-automation-nonprod-uat" ? 1 : 0     #var.name == "iam-automation-nonprod-uat" ? 1 : 0

  provisioner "local-exec" {
    command     = format("%s/scripts/api_permission_uat.sh", path.module)
    interpreter = ["/bin/bash"]
  }
}
