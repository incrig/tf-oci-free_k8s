variable "name" {
  type    = string
  default = "free-k8s"
}

variable "api_private_key" {
  default     = ""
  description = "The contents of the private key file to use with OCI API, optionally base64-encoded. This takes precedence over private_key_path if both are specified in the provider."
  sensitive   = true
  type        = string
}

variable "api_private_key_password" {
  default     = ""
  description = "The corresponding private key password to use with the api private key if it is encrypted."
  sensitive   = true
  type        = string
}

variable "api_private_key_path" {
  default     = ""
  description = "The path to the OCI API private key."
  type        = string
}

variable "home_region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The tenancy's home region. Required to perform identity operations."
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where OKE resources will be created."
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "user_ocid" {
  description = "The id of the user that terraform will use to create the resources."
  type        = string
}

# ssh keys
variable "create_ssh_key_pair" {
  default     = false
  description = "Whether to create an SSH key pair. If set to true, a new SSH key pair is created."
  type        = bool
}

variable "ssh_private_key" {
  default     = ""
  description = "The contents of the private ssh key file, optionally base64-encoded."
  sensitive   = true
  type        = string
}

variable "ssh_private_key_path" {
  default     = "none"
  description = "The path to ssh private key."
  type        = string
}

variable "ssh_public_key" {
  default     = ""
  description = "The contents of the ssh public key."
  type        = string
}

variable "ssh_public_key_path" {
  default     = "none"
  description = "The path to ssh public key."
  type        = string
}

variable "kubernetes_version" {
  default     = ""
  description = "The version of kubernetes to use when provisioning OKE or to upgrade an existing OKE cluster to."
  type        = string
}

variable "node_pool_size" {
  type        = number
  description = "The size of the node pool. Valid values are 1, 2, or 4."
  validation {
    condition     = contains([1, 2, 4], var.node_pool_size)
    error_message = "Accepted values for node_pool_size are 1, 2, or 4."
  }
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}
