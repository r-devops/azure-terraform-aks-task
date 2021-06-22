resource "azurerm_resource_group" "rg" {
  name     = var.RGNAME
  location = var.LOCATION
}

output "RGNAME" {
  value = azurerm_resource_group.rg.name
}

output "LOCATION" {
  value = azurerm_resource_group.rg.location
}
