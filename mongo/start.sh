#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
kubectl create -f "$DIR"/"$TARGET_PLATFORM"/persistent-volume.yaml
kubectl create -f "$DIR"/mongo-cfg.yaml
kubectl apply -f "$DIR"/mongo.yaml
kubectl apply -f "$DIR"/mongo-setup.yaml