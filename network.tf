resource "libvirt_network" "kube_network" {
  name = "k8snet"
  mode = "nat"
  domain = "k8s.local"
  addresses = ["10.0.0.0/24"]
}
