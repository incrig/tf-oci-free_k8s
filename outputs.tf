output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.oke.cluster_id
}

output "cluster_endpoints" {
  description = "Endpoints for the Kubernetes cluster"
  value       = module.oke.cluster_endpoints
}

output "bastion_ids" {
  description = "Map of Bastion Service IDs (cp, workers)"
  value = {
    "cp"      = module.bastion_service_control_plane.bastion_id
    "workers" = module.bastion_service_workers.bastion_id
  }
}

output "worker_pools" {
  description = "Created worker pools."
  value       = module.oke.worker_pools
}

output "compartment_id" {
  description = "The OCID of the compartment that is using Oracle Cloud's Always Free services"
  value       = oci_identity_compartment.free_k8s.id
}

output "vcn_id" {
  description = "The OCID of the Virtual Cloud Network (VCN) created within the compartment using Oracle Cloud's Always Free services."
  value       = module.oke.vcn_id
}
