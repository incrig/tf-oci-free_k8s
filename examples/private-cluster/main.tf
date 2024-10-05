module "tls" {
  source = "./modules/tls"
  count  = var.create_ssh_key_pair == true ? 1 : 0
}

module "free_k8s" {
  source = "../../"
  #  version = "0.0.5"
  # user_ocid     = var.user_ocid
  tenancy_ocid = var.tenancy_ocid
  home_region  = var.home_region
  region       = var.region

  control_plane_is_public     = "false"
  control_plane_allowed_cidrs = ["10.0.0.0/16"]

  providers = {
    oci.home = oci.home
  }
  # private_key_path = var.ssh_private_key_path
}

module "kubernetes" {
  source = "./modules/kubernetes"

  control_plane_bastion_service_id = module.free_k8s.bastion_ids["cp"]
  workers_bastion_service_id       = module.free_k8s.bastion_ids["workers"]

  # ssh keys
  ssh_private_key      = var.create_ssh_key_pair ? chomp(module.tls[0].ssh_private_key) : var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.create_ssh_key_pair ? chomp(module.tls[0].ssh_public_key) : var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path

  cluster_id        = module.free_k8s.cluster_id
  cluster_endpoints = module.free_k8s.cluster_endpoints

  region = var.region
}
