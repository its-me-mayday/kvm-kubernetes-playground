locals {
  control_plane_nodes = 2
  worker_nodes        = 2
}

resource "libvirt_domain" "control-plane" {
  count = local.control_plane_nodes

  name   = "control-plane-${count.index}"
  memory = "1024"
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.control_plane_image[count.index].id
  }

  network_interface {
    network_id = libvirt_network.kube_network.id
    hostname   = "control-plane-${count.index}"
    addresses  = ["10.0.0.${count.index + 2}"]
  }

  cloudinit = libvirt_cloudinit_disk.k8s_cloudinit.id

  depends_on = [libvirt_cloudinit_disk.k8s_cloudinit, libvirt_network.kube_network]
}

resource "libvirt_domain" "worker" {
  count = local.worker_nodes

  name   = "worker-${count.index}"
  memory = "1024"
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.worker_image[count.index].id
  }

  network_interface {
    network_id = libvirt_network.kube_network.id
    hostname   = "worker-${count.index}"
    addresses  = ["10.0.0.${count.index + 10}"]
  }

  cloudinit = libvirt_cloudinit_disk.k8s_cloudinit.id

  depends_on = [libvirt_cloudinit_disk.k8s_cloudinit, libvirt_network.kube_network]
}

resource "libvirt_volume" "base_image" {
  name   = "debian-12-genericcloud-amd64"
  source = "https://cdimage.debian.org/images/cloud/bookworm/20250210-2019/debian-12-genericcloud-amd64-20250210-2019.qcow2"
}

resource "libvirt_volume" "control_plane_image" {
  count = local.control_plane_nodes

  name           = "control-plane-image-${count.index}"
  base_volume_id = libvirt_volume.base_image.id
}

resource "libvirt_volume" "worker_image" {
  count = local.worker_nodes

  name           = "worker-image-${count.index}"
  base_volume_id = libvirt_volume.base_image.id
}
