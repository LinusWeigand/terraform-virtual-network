variable "client_secret" {
  description = "Enter your Client Secret. Please make sure you do not store the value of your client secret in the Source-Code-Management repository."
}

variable "client_id" {
  description = "Your client Id."
  default     = "3e99dfac-e180-4ca5-8ed8-fdca405dc6a6"
}

variable "subscription_id" {
  description = "Your subscription id."
  default     = "2a70cd88-34b2-4240-9c18-221c1564239d"
}

variable "tenant_id" {
  description = "Your tenant id."
  default     = "b9a54e03-5aaf-479f-ad8c-71b81cf06164"
}

variable "prefix" {
  description = "The prefix used for all resources."
  default     = "test"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created."
  default     = "germanywestcentral"
}

variable "dbpassword" {
  description = "The password for the database."
}
