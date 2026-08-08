
data "azurerm_subnet" "subnet" {
  for_each = var.nsg

  name                 = each.value.subnet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
}
data "azurerm_network_security_group" "nsg" {
  for_each = var.nsg
  name = each.value.nsg_name
  resource_group_name = each.value.rg_name
}