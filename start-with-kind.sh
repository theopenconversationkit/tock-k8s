#!/bin/bash
set -e
kubectl config set-context tock-kind \
 --namespace=tock \
 --cluster=kind-kind \
 --user=kind-kind


kubectl config use-context tock-kind

TARGET_PLATFORM=kind ./start.sh