variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
  default     = "68197256-a204-4801-8d8e-9a5c8623c38b"
}

variable "resource_group_name" {
  description = "The name of the existing resource group."
  type        = string
  default     = "ERIC"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Australiaeast"
}

variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
  default = {
  }
}
