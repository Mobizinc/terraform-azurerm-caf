global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  ops = {
    name = "operations"
  }
}
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
      key = "ops"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }
    postgresql_databases = {
      postgresql_database = {
        name = "luna-nonprod-db"
      }
    }
    diagnostic_profiles = {
       eventhubs = {
        definition_key   = "postgresql_servers"
        destination_type = "event_hub"
        destination_key  = "central_logs" # Needs to be created in launchpad
      }
      operation = {
        name             = "testvk"
        definition_key   = "postgresql_servers"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
        # destination_type = "storage" # if using storage account
        # destination_key  = "central_storage"
      }
    }
  }
   luna-nonprod-02 = {
    name       = "p1nc97638"
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
      key = "ops"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }
    postgresql_databases = {
      postgresql_database = {
        name = "luna-nonprod-db"
      }
    }

    diagnostic_profiles = {
       eventhubs = {
        definition_key   = "postgresql_servers"
        destination_type = "event_hub"
        destination_key  = "central_logs" # Needs to be created in launchpad
      }
      operation = {
        name             = "testvk"
        definition_key   = "postgresql_servers"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
        # destination_type = "storage" # if using storage account
        # destination_key  = "central_storage"
      }
    }
  }
  luna-nonprod-03 = {
    name       = "p1nc976380"
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
      key = "ops"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }
    postgresql_databases = {
      postgresql_database = {
        name = "luna-nonprod-db"
      }
    }

    diagnostic_profiles = {
       eventhubs = {
        definition_key   = "postgresql_servers"
        destination_type = "event_hub"
        destination_key  = "central_logs" # Needs to be created in launchpad
      }
      operation = {
        name             = "testvk"
        definition_key   = "postgresql_servers"
        destination_type = "log_analytics"
        destination_key  = "central_logs"

      }
    }




  }
  
}