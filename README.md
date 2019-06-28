# bars83_infra

## Homework - GCP cloud intro
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

## Homework - test application deployment
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

## Homework - Building images with Packer

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