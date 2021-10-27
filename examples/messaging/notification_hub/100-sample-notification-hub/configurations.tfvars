global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  nhub_example = {
    name = "nhub_example"
  }
}

notification_hub_namespaces = {
  nhub1 = {
     name = "nhub1"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }
  nhub2 = {
     name = "nhub2"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }

}