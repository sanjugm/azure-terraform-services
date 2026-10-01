resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "this" {
  name = "${var.vm_name}-vnet"
  address_space = ["10.10.0.0/16"]
  location = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_subnet" "this" {
  name = "${var.vm_name}-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes = ["10.10.1.0/24"]
}
resource "azurerm_public_ip" "this" {
  name = "${var.vm_name}-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}
resource "azurerm_network_security_group" "this" {
  name = "${var.vm_name}-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name = "Allow-SSH"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "this" {
  name = "${var.vm_name}-nic"
  location = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_public_ip.id
  }
}
resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}
resource "azurerm_linux_virtual_machine" "this" {
  name = var.vm_name
  resource_group_name = var.resource_group_name
  location = var.location
  size = "Standard_B2s"
  admin_username = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  disable_password_authentication = var.ssh_public_key != ""
  admin_password = var.ssh_public_key == "" ? var.admin_password : null
  dynamic "admin_ssh_key" {
    for_each = var.ssh_public_key != "" ? [var.ssh_public_key] : []
    content {
      username = var.admin_username
      public_key = admin_ssh_key.value
    }
  }
  os_disk { caching = "ReadWrite" storage_account_type = "Standard_LRS" }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts-gen2"
    version = "latest"
  }
}
