# Create a resource group
resource "azurerm_resource_group" "rg-01" {
  name     = "${var.prefix_name}-${var.environnement}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet-01" {
  name = "${var.prefix_name}-${var.environnement}-vnet"
  address_space = [ var.vnet ]
  tags = var.tag
  location = var.location
  resource_group_name = azurerm_resource_group.rg-01.name
}

resource "azurerm_subnet" "sub-pub-01" {
  count = 3
  name = "${var.prefix_name}-${var.environnement}-sub-pub-${count.index}"
  resource_group_name = azurerm_resource_group.rg-01.name
  virtual_network_name = azurerm_virtual_network.vnet-01.name
  address_prefixes = [cidrsubnet(var.vnet,3,count.index + 1)]
}

resource "azurerm_subnet" "sub-priv-01" {
  count = 3
  name = "${var.prefix_name}-${var.environnement}-sub-private-${count.index}"
  resource_group_name = azurerm_resource_group.rg-01.name
  virtual_network_name = azurerm_virtual_network.vnet-01.name
  address_prefixes = [cidrsubnet(var.vnet,3,count.index + length(azurerm_subnet.sub-pub-01) + 1)]
}

#resource "azurerm_virtual_network_peering" "peering-01" {
#  name = "${var.prefix_name}-${var.environnement}-peering-01"
#  resource_group_name = azurerm_resource_group.rg-01.name
#  virtual_network_name = azurerm_virtual_network.vnet-01.name
#}

#resource "azurerm_virtual_network_peering" "peering-01" {
#  name = "${var.prefix_name}-${var.environnement}-peering-02"
#  resource_group_name = azurerm_resource_group.rg-01.name
#  virtual_network_name = azurerm_virtual_network.vnet-01.name
#}