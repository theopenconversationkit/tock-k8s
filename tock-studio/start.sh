#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl create -f "$DIR"/bot-admin/bot-admin-cfg.yaml
kubectl apply -f "$DIR"/bot-admin/bot-admin.yaml

kubectl create -f "$DIR"/duckling/duckling-cfg.yaml
kubectl apply -f "$DIR"/duckling/duckling.yaml

kubectl create -f "$DIR"/nlp-api/nlp-api-cfg.yaml
kubectl apply -f "$DIR"/nlp-api/nlp-api.yaml

kubectl create -f "$DIR"/kotlin-compiler/kotlin-compiler-cfg.yaml
kubectl apply -f "$DIR"/kotlin-compiler/kotlin-compiler.yaml

kubectl create -f "$DIR"/build-worker/build-worker-cfg.yaml
kubectl apply -f "$DIR"/build-worker/build-worker.yaml

kubectl apply -f "$DIR"/tock-studio.ing.yaml
