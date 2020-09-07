#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl create -n tock -f "$DIR"/mongo-cfg.yaml
kubectl create -n tock -f "$DIR"/mongo.yaml
kubectl create -n tock -f "$DIR"/mongo-setup.yaml