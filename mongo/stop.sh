#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
kubectl delete -f "$DIR"/mongo-cfg.yaml
kubectl delete -f "$DIR"/mongo.yaml
kubectl delete -f "$DIR"/mongo-setup.yaml
kubectl delete -f "$DIR"/"$TARGET_PLATFORM"/persistent-volume.yaml
