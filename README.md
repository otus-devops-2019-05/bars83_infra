# bars83_infra
[![Build Status](https://travis-ci.com/otus-devops-2019-05/bars83_infra.png)](https://travis-ci.com/otus-devops-2019-05/bars83_infra)

## Homework #11 - Ansible #4
1) Using Vagrant
2) Tesing roles with Molecule and Testinfra
3) Set Packer to use Ansible roles
4) Move db role to external repo
5) TravisCI for repo with external role

## Homework #10 - Ansible #3
1) Ansible - from playbooks to roles
2) Split Ansible configuration to prod and stage environments
3) Use community role for setup nginx
4) Ansible Valut for secrets storing
5) Dynamic inventory for environments
6) TraviCI tests for Ansible, Packer, Terraform


## Homework #9 - Ansible #2
1) Ansible playbooks, handlers, templates ([jinja2](http://jinja.pocoo.org/docs/2.10/)) with one play in playbook
2) Ansible playbook with several plays
3) Several Ansible playbooks
4) Packer images provisioning with ansible playbooks


## Homework #8 - Ansible #1
* ``ansible-playbook clone.yml`` -> ``ansible app -m command -a 'rm -rf ~/reddit'`` -> ``ansible-playbook clone.yml`` - first playbook run shows server is not changed (reddit already exists from previous step in homework), second playbook run shows server is changed (reddit was not exists)
* (*) task:
  1. create static JSON-inventory (``ansible/inventory.json``)
  2. confirure terraform to generate dinamyc inventory in json format as output variable (``terraform output dynamic_inventory`` now shows actual servers)
  3. create bash srcipt (``dynamic-inventory.sh``) to get output var from terraform and return it to ansible as inventory

## Homework #7 - IaC with Terraform #2
1) Remove load balancer confiruration from previous homework
2) Import firewall rule from GCP to terraform state
3) Test resource dependencies
4) Split config to have two instances - one for application and one for database
5) Split main.tf to separate config files - app.tf, db.tf, vpc.tf
6) Use terraform modules in single and multi environments
7) Use [storage-bucket](https://registry.terraform.io/modules/SweetOps/storage-bucket/google) plugin from terraform registry to store states in remote buckets
8) Add optional provisioning to app instance
9) Because app and db is now on different instances, it needs to modify mongodb config (``bindIP``) on base image, and set environment variable DATABASE_URL on app instance


## Homework #6 - IaC with Terraform
1) Remove project wide SSH keys from GCP
2) Install [terraform 0.11.11](https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip)
```
> terraform -v                                                              
Terraform v0.11.11
```
3) Plan IaC (instance, provisioning, fw rule) in ``main.tf``, ``variables.tf``, ``terraform.tfvars``
4) Add files for provisioning in ``files/``
5) Output variables described in ``outputs.tf``
6) SSH keys for several users
```
resource "google_compute_project_metadata" "default" {
  metadata = {
    # путь до публичного ключа
    ssh-keys = "appuser1:${file(var.project_public_key_path)}appuser2:${file(var.project_public_key_path)}"
  }
}
```
7) Added ``lb.tf`` with code for load balancing
8) ``main.tf``, ``variables.tf``, ``outputs.tf`` modified for several app instances (``count = n``)






## Homework #5 - Building images with Packer

### Base tasks:
1) Installed Packer  
2) Application Default Credentials (ADC) created
    - `gcloud auth application-default login`
3) Added template for image (`ubuntu16.json`)
4) Template validated with `packer validate ./ubuntu16.json`
5) VM created from GCP web console
6) Application reddit-app deployed by script:
```
#! /bin/bash
git clone -b monolith https://github.com/express42/reddit.git
$ cd reddit && bundle install
$ puma -d 
```
7) Some template parameters were moved to variables

Summary: we have a "fry" image with manual application deploy

### Advanced tasks:
1) Created template `immutable.json` for "baked" image with reddit-app
2) Added script `create-redditvm.sh` for VM creation based on "baked" image

Summary: we have a "baked" image with already deploed application

## Homework #4 - test application deployment
1) Installed and initialized Cloud SDK 
2) Created VM instance
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
```
3) Installed Ruby
```
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
```
4) Installed MongoDB
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt update && sudo apt install -y mongodb-org
sudo systemctl start mongod && sudo systemctl enable mongod && sudo systemctl status mongod
```
5) Test application deployed
```
cd ~/
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
ps aux | grep puma
```
6) Firewall rule for port 9292 created in GCP console
7) Bash scripts created for Ruby, MongoDB installation and application deployment

### Advanced task
1) Startup script created (```startup.sh```)
2) VM instance created with startup script
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh
```
3) Firewall rule created with command
```
gcloud compute firewall-rules create default-puma-server \
    --allow=tcp:9292 \
    --target-tags=puma-server
```
### Test app (reddit-app) endpoint for CI
testapp_IP = 34.68.146.214

testapp_port = 9292


## Homework #3 - GCP cloud intro
1) Remote internal server SSH in one command:
```ssh -A -t user@35.209.46.30 ssh someinternalhost```

2) Create alias for command ```ssh someinternalhost```
```
cat ~/.ssh/config
	Host someinternalhost
	ProxyCommand ssh -A user@35.209.46.30 -W %h:%p
```

### VPN config for CI

bastion_IP = 35.209.46.30

someinternalhost_IP = 10.128.0.5
