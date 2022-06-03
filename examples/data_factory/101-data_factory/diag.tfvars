postgresql_flexible_servers = {

  luna-nonprod-01 = {
    name       = "p1nc9763"
    region     = "region1"
    version    = "13"
    sku_name   = "GP_Standard_D2s_v3"
    storage_mb = 1048576
    # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432
    public_network_access_enabled = true
    backup_retention_days         = "35"
    zone                          = "2"
    administrator_password = "1234567899"
    resource_group = {
      key = "funapp"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }
    postgresql_databases = {
      postgresql_database = {
        name = "luna-nonprod-db"
      }
    }

    diagnostic_profiles = {
      dsa1 = {
        name             = "log_and_metrics_log_storage"
        definition_key   = "storage"
        destination_type = "storage"
        destination_key  = "all_regions"
      }


    }




  }

}
diagnostic_storage_accounts = {
  dsa1 = {
    name                     = "dsa1dev"
    resource_group_key       = "funapp"
    region                   = "region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      team        = "IT"
    }
    enable_system_msi = true
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "funapp"
    region             = "region1"
    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}

diagnostics_definition = {
  storage = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["StorageRead", true, false, 14],
        ["StorageWrite", true, false, 14],
   
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }
}

## destinations definition
diagnostics_destinations = {
  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
  storage = {
    all_regions = {
      southeastasia = {
        storage_account_key = "dsa1_region1"
      }
    }
  }
}
