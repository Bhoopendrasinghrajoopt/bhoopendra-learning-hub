resource "azurerm_resource_group" "rg-resource" {
  for_each   = var.rgs

  name       = each.value.name
  location   = each.value.rg-location
  managed_by = each.value.managed_by
}
