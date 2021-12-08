
global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
   
    
  }
}

resource_groups = {
  ase_region1 = {
    name = "aks_proxy_test"
  }

}

aks_proxy = {
  aks_cluster = {
    resource_group_key = "ase_region1"
    name               = "proxy_aks"
    vnet_key           = "ase_region1"
    subnet_key         = "ase1"
    httpProxy          = "http://blabla.example.com:8080/"
    httpsProxy         = "http://blabla.example.com:8080/"
    
    
    
    
    

    
  }
}



vnets = {
  ase_region1 = {
    resource_group_key = "ase_region1"
    vnet = {
      name          = "testvk"
      address_space = ["10.28.130.0/24"]
    }
    specialsubnets = {}
    subnets = {
      ase1 = {
        name    = "testvkaks"
        cidr    = ["10.28.130.0/24"]
        
      }
    }

    # you can setup up to 5 keys - vnet diganostic
 

  }
}

