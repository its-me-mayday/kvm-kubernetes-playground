resource "libvirt_domain" "control-plane" {
  name   = "debian"
  memory = "1024"
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.debian_image.id
  }

  network_interface {
    network_id = libvirt_network.kube_network.id
    hostname   = "control-plane-1"
    addresses  = ["10.0.0.2"]
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  cloudinit = libvirt_cloudinit_disk.k8s_cloudinit.id

  depends_on = [libvirt_cloudinit_disk.k8s_cloudinit, libvirt_network.kube_network]
}

resource "libvirt_volume" "debian_image" {
  name   = "debian-12-genericcloud-amd64"
  source = "https://cdimage.debian.org/images/cloud/bookworm/20250210-2019/debian-12-genericcloud-amd64-20250210-2019.qcow2"
}
