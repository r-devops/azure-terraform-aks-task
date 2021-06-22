resource "azurerm_virtual_network" "network" {
  name                        = "${var.RGNAME}-network"
  address_space               = var.NETWORK_CIDR
  location                    = var.LOCATION
  resource_group_name         = var.RGNAME
}

resource "azurerm_subnet" "subnets" {
  count                       = length(var.SUBNET_CIDRS)
  name                        = "subnet-${count.index+1}"
  resource_group_name         = var.RGNAME
  virtual_network_name        = azurerm_virtual_network.network.name
  address_prefixes            = [element(var.SUBNET_CIDRS, count.index)]
}

output "SUBNETS" {
  value = azurerm_subnet.subnets.*.id
}
