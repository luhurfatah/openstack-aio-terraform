# What's This?

This repository provides a basic Terraform configuration for setting up OpenStack All-in-One on a single KVM instance using the libvirt provider. The OpenStack deployment is managed through Cloud Init, which is configured within the Terraform file. To use this configuration successfully, you'll need a functional KVM setup on your machine, including storage pools named "isos" and "vms." Additionally, make sure you have the Ubuntu Jammy image saved in your "isos" storage pool.


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

# Details

This repository contains Terraform configuration files for deploying an OpenStack instance using the libvirt provider. The configuration includes:

- `main.tf`: Terraform configuration file for setting up the OpenStack instance.
- `openstack-network.cfg`: Network configuration file for the OpenStack instance.
- `openstack.cfg`: Cloud-init configuration file for the OpenStack instance.

## Usage

To use this configuration, make sure you have Terraform installed, and modify the configuration files as needed. Then, run:

```bash
terraform init
terraform apply
```
After the VM is successfully built, you can see the log of cloud init using this command :
```
ssh <ip VM>
tail -f /var/log/cloud-init-output.log 
```
