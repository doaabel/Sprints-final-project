### 2-  Deploy k3s 1 master and 1 node using Ansible

Assuming you have Ansible installed, create an inventory file named hosts.ini and add the following content:


Replace <master-vm-ip> and <node-vm-ip> with the actual IP addresses of the VMs in inventory file named hosts.ini 

Deploy k3s cluster

```
ansible-playbook -i hosts.ini deploy-k3s.yml
```