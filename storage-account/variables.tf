variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-tf-storage-demo"
}

variable "storage_account_name" {
  description = "Globally unique storage account name"
  type        = string
}

variable "container_name" {
  description = "Blob container name"
  type        = string
  default     = "demo-container"
}
