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
  nhubname1example = {
     name = "nhub1example"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }
  nhubname2example = {
     name = "nhub2example"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }

}


notification_hub = {
  nhub1example = {
    name = "nhubexample"
    namespace_name = "nhub1example"
    resource_group_key = "nhub_example"
  }
  nhub2example = {
    name = "nhubexample"
    namespace_name = "nhubname2example"
    resource_group_key = "nhub_example"
  }
}