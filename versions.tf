terraform {
  required_version = ">= 1.9.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci.home]
      version               = "6.12.0"
    }
  }
}
