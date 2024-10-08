output "cluster_endpoints" {
  description = "Endpoints for the Kubernetes cluster"
  value       = module.free_k8s.cluster_endpoints
}

output "bastion_ids" {
  description = "Map of Bastion Service IDs (cp, workers)"
  value       = module.free_k8s.bastion_ids
}

output "worker_pools" {
  description = "Created worker pools."
  value       = module.free_k8s.worker_pools
}
