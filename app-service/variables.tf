variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-tf-appservice-demo"
}

variable "app_name" {
  description = "Globally unique App Service name"
  type        = string
}

variable "sku_name" {
  description = "App Service Plan SKU"
  type        = string
  default     = "B1"
}
