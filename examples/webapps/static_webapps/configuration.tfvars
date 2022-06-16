global_settings = {
  default_region = "region2"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapp_simple = {
    name   = "webapp-simple"
    region = "region2"
  }
}

keyvaults = {
  vm-kv = {
    name               = "vm-kv"
    resource_group_key = "webapp_simple"
    sku_name           = "standard"
    
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

dynamic_keyvault_secrets = {
  vm-kv = { # Key of the keyvault
    admin-username = {
      secret_name = "admin-username"
      value       = "ghp_xxxxxxxxxxxxxxxxxxx"
    }

  }
}

static_webapps = {
  example_1 = {
    resource_group_key   = "webapp_simple"
    name                 = "static-webapps-vk"
    sku                  = "Standard" 
    github_repo = "https://github.com/xxx/xxx.git"
    github_branch = "main"
    keyvault_secret_name = "admin-username"
    keyvault = {
      key = "vm-kv" # (Required) when auto-generated administrator credentials needed.
      # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }
  }
}