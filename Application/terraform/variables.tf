variable "agent_count" {
  default = 3
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = "__ServicePrincipalClientId__"
}

variable "aks_service_principal_client_secret" {
  default = "__ServicePrincipalClientSecret__"
}

variable "cluster_name" {
  default = "__AksName__"
}

variable "dns_prefix" {
  default = "__AksNameDNS__"
}

variable "resource_group_location" {
  default     = "__RgLocation__"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "__RgName__"
  description = "resource group name"
}
