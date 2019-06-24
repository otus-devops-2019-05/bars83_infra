#!/bin/bash

#create firewall rule for 9292 port
gcloud compute firewall-rules create default-puma-server \
    --allow=tcp:9292 \
    --target-tags=puma-server
