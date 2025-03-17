resource "libvirt_domain" "control-plane" {
  name   = "debian"
  memory = "1024"
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.debian12genericcloud.id
  }

  network_interface {
    network_id     = libvirt_network.kube_network.id
    hostname       = "control-plane-1"
    addresses      = ["10.0.0.2"]
  }
}

resource "libvirt_volume" "debian12genericcloud" {
  name   = "debian-12-genericcloud-amd64"
  source = "https://cdimage.debian.org/images/cloud/bookworm/20250210-2019/debian-12-genericcloud-amd64-20250210-2019.qcow2"
}
