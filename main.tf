provider "libvirt" {
  uri = "qemu:///system"
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

# openstack
data "template_file" "openstack_user_data" {
  template = file("${path.module}/openstack.cfg")
}

data "template_file" "openstack_network_config" {
  template = file("${path.module}/openstack-network.cfg")
}

resource "libvirt_cloudinit_disk" "openstack-cloudinit" {
  name           = "openstack-cloudinit.iso"
  pool           = "vms"
  user_data      = data.template_file.openstack_user_data.rendered
  network_config = data.template_file.openstack_network_config.rendered
}

resource "libvirt_volume" "openstack-vda" {
  name             = "openstack-vda.qcow2"
  pool             = "vms"
  base_volume_name = "ubuntu-jammy.img"
  base_volume_pool = "isos"
  size             = "268435456000"
  format           = "qcow2"
}


resource "libvirt_domain" "openstack" {
  name   = "openstack"
  memory = "16384"
  vcpu   = "8"

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.openstack-cloudinit.id

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

  network_interface {
    network_name = "net-10.10.10"
    addresses    = ["10.10.10.10"]
  }

  network_interface {
    network_name = "net-10.10.20"
    addresses    = ["10.10.20.10"]
  }

  network_interface {
    network_name = "net-10.10.30"
    addresses    = ["10.10.30.10"]
  }

  disk {
    volume_id = libvirt_volume.openstack-vda.id
  }


  video {
    type = "vga"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
