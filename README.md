# What's This?

This document provides a straightforward Terraform configuration for deploying OpenStack All-in-One on a single KVM instance using the libvirt provider. To successfully execute this configuration, ensure that you have a working KVM setup on your machine with storage pools named isos and vms. Additionally, make sure you have the Ubuntu Jammy image saved in your isos storage pool.


If you haven't do that, you can create a new pool using this command :

```
sudo virsh pool-define-as \
    --name vms \
    --type dir \
    --target /data/vms

sudo virsh pool-define-as \
    --name isos \
    --type dir \
    --target /data/isos

```

# Specifification
- VM OS: Ubuntu 22
- Openstack: Zed


# How to run?
Initialize terraform
```
teraform init
```

Deploy VMs
```
terraform apply
```

SSH into the VM
```
ssh 10.10.10.10
```

Tail the log
```
tail -f /var/log/cloud-init-output.log 
```