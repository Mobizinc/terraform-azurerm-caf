global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  private_dns_region1 = {
    name   = "postgretestvk"
    region = "region1"
  }
}

private_dns_vnet_links = {
  vnet_pvtdns_link1 = {
    vnet_key = "vnet_test"
    #lz_key = "remote landing zone key for vnet"
    private_dns_zones = {
      dns_zone1 = {
        name = "dns1-lnk"
        key  = "dns1"
        #lz_key = "provide the landing zone key of private dns zone"
      }
     
    }
  }
  
}

private_dns = {
  dns1 = {
    name               = "examplevk.postgres.database.azure.com"
    resource_group_key = "private_dns_region1"

    
  }
}
vnets = {
  vnet_test = {
    resource_group_key = "private_dns_region1"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.28.131.0/24"]
    }
    specialsubnets = {

    }
    subnets = {
        testvk = {
        name    = "postgretest"
        cidr    = ["10.28.131.0/24"]
        delegation = {
          name               = "fs"
          service_delegation = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = [
           
          "Microsoft.Network/virtualNetworks/subnets/join/action"],
        }
      }
    }
  }
}




postgresql_flexible_server = {
  postgre = {
          name                = "postgretestvks"
          resource_group_key = "private_dns_region1"
          
          version             = "12"
          sku_name            = "GP_Standard_D4s_v3"
          zone                = "1"
          vnet_key            = "vnet_test"
          subnet_key          = "testvk"
          administrator_login          = "psqladmin"
          administrator_login_password = "H@Sh1CoR3!"
          
          private_dns_zone = {
           #lz_key = "example"
           key     = "dns1"
          }
          storage_mb                        = "32768"
          create_mode                       = "Default"
          
  }
}