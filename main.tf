module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"

  tenancy_ocid = var.tenancy_ocid

  region      = var.region
  home_region = var.home_region

  # ssh keys
  ssh_private_key      = var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path

  # general oci parameters
  compartment_id = oci_identity_compartment.free_k8s.id

  # bastion host
  create_bastion = false
  # operator host
  create_operator = false

  # oke cluster options
  cluster_name                = var.name
  control_plane_allowed_cidrs = var.control_plane_allowed_cidrs
  kubernetes_version          = var.kubernetes_version
  cluster_type                = "basic"

  control_plane_is_public           = true
  assign_public_ip_to_control_plane = false

  # node pools
  worker_pool_mode = "node-pool"

  worker_pools = {
    arm-ampere-a1-free-tier = {
      size             = var.node_pool_size,
      shape            = "VM.Standard.A1.Flex",
      ocpus            = local.max_cores_free_tier / var.node_pool_size,
      memory           = local.max_memory_free_tier_gb / var.node_pool_size,
      boot_volume_size = var.node_pool_boot_size,
      create           = true,
      label = {
        pool         = "arm-ampere-a1-free-tier",
        architecture = "arm",
        pool-type    = "free-tier",
        processor    = "ampere-a1",
        shape        = "VM.Standard.A1.Flex",
        region       = var.home_region
      }
    }
  }

  worker_image_os_version = var.node_pool_os_version

  # oke load balancers
  load_balancers          = "both"
  preferred_load_balancer = "public"

  providers = {
    oci.home = oci.home
  }
}

module "bastion_service_control_plane" {
  source = "./modules/bastion-service"

  # general oci parameters
  compartment_id = oci_identity_compartment.free_k8s.id
  label_prefix   = var.label_prefix

  # bastion service parameters
  bastion_service_access        = var.bastion_service_access
  bastion_service_name          = "${var.name}-cp"
  bastion_service_target_subnet = module.oke.control_plane_subnet_id
  vcn_id                        = module.oke.vcn_id
}

module "bastion_service_workers" {
  source = "./modules/bastion-service"

  # general oci parameters
  compartment_id = oci_identity_compartment.free_k8s.id
  label_prefix   = var.label_prefix

  # bastion service parameters
  bastion_service_access        = var.bastion_service_access
  bastion_service_name          = "${var.name}-workers"
  bastion_service_target_subnet = module.oke.worker_subnet_id
  vcn_id                        = module.oke.vcn_id
}
