#!/bin/bash

#create VM from baked image
gcloud compute instances create reddit-app-full \
  --image-family reddit-full \
  --restart-on-failure \
  --machine-type=g1-small \
  --tags puma-server \
