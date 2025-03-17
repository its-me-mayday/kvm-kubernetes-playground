# Repository Description: KVM Kubernetes Playground

> A Terraform/OpenTofu project to provision a local Kubernetes cluster on KVM virtualization, using libvirt for infrastructure management and cloud-init for node configuration.

## Key Features 🌟
Infrastructure as Code: Full cluster definition using OpenTofu

### Multi-Node Architecture:

- n Control Plane nodes (10.0.0.*)
- n Worker nodes (10.0.0.*)

### Automatic Kubernetes Tooling Installation:

- kubeadm 1.28.15
- kubectl 1.28.15
- kubelet 1.28.15

### Secure Baseline Configuration:

- SSH key authentication
- Swap disabled
- Containerd runtime

## Tech Stack 🛠️
| Component | Technology |
|-----------|------------|
|Infrastructure | OpenTofu 1.9.0 |
|Virtualization	| Libvirt/QEMU |
|OS	| Debian 12 (Bookworm) |
|Network	| NATed libvirt network |
|Config Management |	cloud-init |

## Structure 📂

```bash
├── cloud_init.tf       # Cloud-init disk resource
├── domains.tf          # VM definitions (control plane/workers)
├── network.tf          # Kubernetes network configuration
├── main.tf             # Provider configuration
└── cloud_init.yml      # Base node configuration
```

## Getting Started
- install `kvm`
- install `mkisofs`
- setup `security_driver="none"` on `/etc/libvirt/qemu.conf` 

## Usage 🚀
### Deploy Cluster:
```bash
$ make init && make apply
```

### Destroy Cluster:
```bash
$ make destroy
```

### Connect to Nodes:
```bash
$ ssh user@10.0.0.*
```

## Customization ⚙️

1. Scale Nodes:

```hcl
# domains.tf
locals {
  control_plane_nodes = 3  # ← Modify node counts
  worker_nodes        = 3
}
```

2. Update Kubernetes Version:

```yaml
# cloud_init.yml
apt-get install -y kubelet=1.29.0-1.1 kubeadm=1.29.0-1.1 kubectl=1.29.0-1.1
```

## License 📄
Released under The Unlicense - completely free for any use.

## Changelog 📆
See CHANGELOG.md for version history and notable changes.
