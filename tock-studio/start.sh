#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl create -n tock -f "$DIR"/bot-admin/bot-admin-cfg.yaml
kubectl apply -n tock -f "$DIR"/bot-admin/bot-admin.yaml

kubectl create -n tock -f "$DIR"/duckling/duckling-cfg.yaml
kubectl apply -n tock -f "$DIR"/duckling/duckling.yaml

kubectl create -n tock -f "$DIR"/nlp-api/nlp-api-cfg.yaml
kubectl apply -n tock -f "$DIR"/nlp-api/nlp-api.yaml

kubectl create -n tock -f "$DIR"/kotlin-compiler/kotlin-compiler-cfg.yaml
kubectl apply -n tock -f "$DIR"/kotlin-compiler/kotlin-compiler.yaml

kubectl create -n tock -f "$DIR"/build-worker/build-worker-cfg.yaml
kubectl apply -n tock -f "$DIR"/build-worker/build-worker.yaml

kubectl apply -n tock -f "$DIR"/tock-studio.ing.yaml
