variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
  default     = "chatwithpdf"
}

variable "resource_group_location" {
  description = "Location of resource group"
  type        = string
  default     = "Central India"
}

variable "storage_account_name" {
  description = "Name of state storage account"
  type        = string
  default     = "chatwithpdfstate"
}

variable "storage_container_name" {
  description = "Name of state storage account"
  type        = string
  default     = "tfstate"
}

variable "storage_key" {
  description = "Name of state storage account"
  type        = string
  default     = "./terraform.tfstate"
}

variable "manager_instance_count" {
  description = "Number of Manager VM instances to create"
  type        = number
  default     = 1
}

variable "worker_instance_count" {
  description = "Number of Worker VM instances to create"
  type        = number
  default     = 1
}

variable "gpu_instance_count" {
  description = "Number of GPU Worker VM instances to create"
  type        = number
  default     = 1
}

variable "manual_instance_count" {
  description = "Number of GPU Worker VM instances to create"
  type        = number
  default     = 1
}

variable "manager_instance_size" {
  description = "Size of Manager VM instances"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "worker_instance_size" {
  description = "Size of Worker VM instances"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "gpu_instance_size" {
  description = "Size of GPU Worker VM instances"
  type        = string
  default     = "Standard_NC4as_T4_v3"
}

variable "manual_instance_size" {
  description = "Size of GPU Worker VM instances"
  type        = string
  default     = "Standard_E2bds_v5"
}

variable "worker_disk_size" {
  description = "Size of Worker VM Disk"
  type        = number
  default     = 50
}

variable "gpu_disk_size" {
  description = "Size of GPU Worker VM Disk"
  type        = number
  default     = 100
}

variable "manager_disk_size" {
  description = "Size of Manager VM Disk"
  type        = number
  default     = 50
}

variable "manual_disk_size" {
  description = "Size of Manager VM Disk"
  type        = number
  default     = 128
}
