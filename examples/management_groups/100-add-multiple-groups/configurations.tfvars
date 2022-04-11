management_groups = [
  {
    display_name = "level0"
    # parent_management_groups_key = "xxx-xxx-xxxx-xxx-xxxx"
  },
  {
    display_name = "level2"
  },
  {
    display_name = "level3"
  },
  {
    display_name = "launchpad"
    parent_management_groups_key = "caf_level0"
    subscription_ids = ["xxx-xxx-xxxx-xxx-xxxx"]
  },
  {
    display_name = "hub"
    parent_management_groups_key = "caf_level2"
    subscription_ids = ["xx-xxx-xxx-xxxx-xxxx"]

  },
  {
    display_name = "spoke"
    parent_management_groups_key = "caf_level3"
    subscription_ids = ["xxx-xxxx-xxxx-xxx-xxx"]

  }
]