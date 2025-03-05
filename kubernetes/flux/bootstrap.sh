#!/bin/bash

if [ -z $1 ] ;then
  echo $1 missing
  echo $0 mgmt
  exit 0
fi

ENVIRONMENT=$1
echo flux bootstrap github  --owner=pintv   --repository=infrastructure --private-key-file=~/development/pintv/data/files/flux-pem-file --branch=master --path=kubernetes/flux/$1  --namespace=flux-system  --verbose
