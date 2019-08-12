#!/bin/bash
set -e

docker run --rm -v $(pwd)/terraform:/data -t wata727/tflint
docker run --rm -v $(pwd)/terraform/stage:/data -t wata727/tflint
docker run --rm -v $(pwd)/terraform/prod:/data -t wata727/tflint

terraform validate -check-variables=false ./terraform
terraform validate -check-variables=false ./terraform/stage
terraform validate -check-variables=false ./terraform/prod