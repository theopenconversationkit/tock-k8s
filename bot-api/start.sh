#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl create  -f "$DIR"/bot-api-cfg.yaml
kubectl apply  -f "$DIR"/bot-api.yaml


kubectl apply  -f "$DIR"/bot-api.ing.yaml
