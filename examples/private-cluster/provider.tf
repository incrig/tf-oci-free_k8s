provider "oci" {
  private_key  = local.api_private_key
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
}

provider "oci" {
  private_key  = local.api_private_key
  region       = var.home_region
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  alias        = "home"
}
