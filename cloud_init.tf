resource "libvirt_cloudinit_disk" "k8s_cloudinit" {
  name      = "k8s-control-plane-cloudinit.iso"
  user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.yml")
}
