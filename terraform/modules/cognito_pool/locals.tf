locals {
  user_attribute_schema = length(var.user_attribute_schema) > 0 ? {
  for attribute in var.user_attribute_schema :
    attribute.name => {
      name                     = attribute.name
      attribute_data_type      = attribute.attribute_data_type
      developer_only_attribute = attribute.developer_only_attribute
      mutable                  = attribute.mutable
      required                 = attribute.required
      min_length               = attribute.min_length
      max_length               = attribute.max_length
    }
  } : {}

  account_recovery_settings = length(var.account_recovery_mechanisms) > 0 ? {
    enabled = true
  } : {}

  account_recovery_mechanisms = length(var.account_recovery_mechanisms) > 0 ? {
    for index, mechanism_name in var.account_recovery_mechanisms :
    mechanism_name => {
      name     = mechanism_name
      priority = index + 1
    }
  } : {}
}