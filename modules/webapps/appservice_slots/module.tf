data "azurerm_app_service" "app_services_name" {
  name                = var.app_service_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_app_service_slot_virtual_network_swift_connection" "vnet_config" {
 depends_on = [azurerm_app_service_slot.slots]
 for_each  =  var.vnet_integration

 slot_name      = var.name
 app_service_id = data.azurerm_app_service.app_services_name.id
 subnet_id      = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
 lifecycle {
    ignore_changes = [
      app_service_id
    ]
  }
}

resource "azurerm_app_service_slot" "slots" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  app_service_name    = var.app_service_name 
  tags                = local.tags

  client_affinity_enabled = lookup(var.settings, "client_affinity_enabled", null)
  enabled                 = lookup(var.settings, "enabled", null)
  https_only              = lookup(var.settings, "https_only", null)

  dynamic "identity" {
    for_each = try(var.identity, null) != null ? [1] : []

    content {
      type         = try(var.identity.type, null)
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  key_vault_reference_identity_id = can(var.settings.key_vault_reference_identity.key) ? var.combined_objects.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.key_vault_reference_identity.key].id : try(var.settings.key_vault_reference_identity.id, null)
  
  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      
      always_on                 = lookup(var.settings.site_config, "always_on", false)
      app_command_line          = lookup(var.settings.site_config, "app_command_line", null)
      default_documents         = lookup(var.settings.site_config, "default_documents", null)
      dotnet_framework_version  = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                = lookup(var.settings.site_config, "ftps_state", "FtpsOnly")
      http2_enabled             = lookup(var.settings.site_config, "http2_enabled", false)
      java_version              = lookup(var.settings.site_config, "java_version", null)
      java_container            = lookup(var.settings.site_config, "java_container", null)
      java_container_version    = lookup(var.settings.site_config, "java_container_version", null)
      local_mysql_enabled       = lookup(var.settings.site_config, "local_mysql_enabled", null)
      linux_fx_version          = lookup(var.settings.site_config, "linux_fx_version", null)
      windows_fx_version        = lookup(var.settings.site_config, "windows_fx_version", null)
      managed_pipeline_mode     = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      min_tls_version           = lookup(var.settings.site_config, "min_tls_version", "1.2")
      php_version               = lookup(var.settings.site_config, "php_version", null)
      python_version            = lookup(var.settings.site_config, "python_version", null)
      remote_debugging_enabled  = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      remote_debugging_version  = lookup(var.settings.site_config, "remote_debugging_version", null)
      use_32_bit_worker_process = lookup(var.settings.site_config, "use_32_bit_worker_process", false)
      websockets_enabled        = lookup(var.settings.site_config, "websockets_enabled", false)
      scm_type                  = lookup(var.settings.site_config, "scm_type", null)
      vnet_route_all_enabled    = lookup(var.settings.site_config, "vnet_route_all_enabled", false)
      health_check_path = lookup(var.settings.site_config, "health_check_path", null)
      
      dynamic "cors" {
        for_each = lookup(var.settings.site_config, "cors", {}) != {} ? [1] : []

        content {
          allowed_origins     = lookup(var.settings.site_config.cors, "allowed_origins", null)
          support_credentials = lookup(var.settings.site_config.cors, "support_credentials", null)
        }
      }
      dynamic "ip_restriction" {
        for_each = lookup(var.settings.site_config, "ip_restriction", {}) != {} ? [1] : []

        content {
          ip_address                = lookup(var.settings.site_config.ip_restriction, "ip_address", null)
          virtual_network_subnet_id = lookup(var.settings.site_config.ip_restriction, "virtual_network_subnet_id", null)
        }
      }
    }
  }

  app_settings = var.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      additional_login_params        = lookup(var.settings.auth_settings, "additional_login_params", null)
      allowed_external_redirect_urls = lookup(var.settings.auth_settings, "allowed_external_redirect_urls", null)
      default_provider               = lookup(var.settings.auth_settings, "default_provider", null)
      issuer                         = lookup(var.settings.auth_settings, "issuer", null)
      runtime_version                = lookup(var.settings.auth_settings, "runtime_version", null)
      token_refresh_extension_hours  = lookup(var.settings.auth_settings, "token_refresh_extension_hours", null)
      token_store_enabled            = lookup(var.settings.auth_settings, "token_store_enabled", null)
      unauthenticated_client_action  = lookup(var.settings.auth_settings, "unauthenticated_client_action", null)

      dynamic "active_directory" {
        for_each = lookup(var.settings.auth_settings, "active_directory", {}) != {} ? [1] : []

        content {
          client_id         = var.settings.auth_settings.active_directory.client_id
          client_secret     = lookup(var.settings.auth_settings.active_directory, "client_secret", null)
          allowed_audiences = lookup(var.settings.auth_settings.active_directory, "allowed_audiences", null)
        }
      }

      dynamic "facebook" {
        for_each = lookup(var.settings.auth_settings, "facebook", {}) != {} ? [1] : []

        content {
          app_id       = var.settings.auth_settings.facebook.app_id
          app_secret   = var.settings.auth_settings.facebook.app_secret
          oauth_scopes = lookup(var.settings.auth_settings.facebook, "oauth_scopes", null)
        }
      }

      dynamic "google" {
        for_each = lookup(var.settings.auth_settings, "google", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.google.client_id
          client_secret = var.settings.auth_settings.google.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.google, "oauth_scopes", null)
        }
      }

      dynamic "microsoft" {
        for_each = lookup(var.settings.auth_settings, "microsoft", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.microsoft.client_id
          client_secret = var.settings.auth_settings.microsoft.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.microsoft, "oauth_scopes", null)
        }
      }

      dynamic "twitter" {
        for_each = lookup(var.settings.auth_settings, "twitter", {}) != {} ? [1] : []

        content {
          consumer_key    = var.settings.auth_settings.twitter.consumer_key
          consumer_secret = var.settings.auth_settings.twitter.consumer_secret
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      site_config[0].scm_type
    ]
  }
}
