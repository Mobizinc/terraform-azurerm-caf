module "management_groups" {
  source = "./modules/management_groups"
  for_each = {for key, value in var.management_groups: key => value}

  settings                         = var.management_groups[each.key]
}


