variable "prefix" {
  description = "The prefix used for all resources."
  default     = "test"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created."
  default     = "germanywestcentral"
}

variable "environment" {
  description = "The Azure Region in which all reources should be created."
  default     = "Production"
}
