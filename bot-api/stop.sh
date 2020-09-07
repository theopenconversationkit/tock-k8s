#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl delete -n tock -f "$DIR"/bot-api-cfg.yaml
kubectl delete -n tock -f "$DIR"/bot-api.yaml

kubectl delete -n tock -f "$DIR"/bot-api.ing.yaml
