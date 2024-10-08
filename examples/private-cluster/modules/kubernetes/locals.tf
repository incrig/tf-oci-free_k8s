locals {
  private_endpoint_ip   = split(":", var.cluster_endpoints["private_endpoint"])[0]
  private_endpoint_port = split(":", var.cluster_endpoints["private_endpoint"])[1]

  ssh_private_key = (
    var.ssh_private_key != ""
    ? try(base64decode(var.ssh_private_key), var.ssh_private_key)
    : var.ssh_private_key_path != "none"
    ? file(var.ssh_private_key_path)
  : null)
  ssh_authorized_keys = (var.ssh_public_key != "") ? var.ssh_public_key : (var.ssh_public_key_path != "none") ? file(var.ssh_public_key_path) : ""
}
