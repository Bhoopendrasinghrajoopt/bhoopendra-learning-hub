data "azurerm_subnet" "subnet" {
  for_each             = var.hotstar_VM
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "pip" {
  for_each            = var.hotstar_VM
  resource_group_name = each.value.rg_name
  name                = each.value.pip_name

}
data "azurerm_network_interface" "hotstar_nic" {
  for_each = var.hotstar_VM
  name = each.value.nic_name
  resource_group_name = each.value.rg_name
}