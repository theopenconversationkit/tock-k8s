#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl delete  -f "$DIR"/bot-admin/bot-admin-cfg.yaml
kubectl delete  -f "$DIR"/bot-admin/bot-admin.yaml

kubectl delete  -f "$DIR"/duckling/duckling-cfg.yaml
kubectl delete  -f "$DIR"/duckling/duckling.yaml

kubectl delete  -f "$DIR"/nlp-api/nlp-api-cfg.yaml
kubectl delete  -f "$DIR"/nlp-api/nlp-api.yaml

kubectl delete  -f "$DIR"/kotlin-compiler/kotlin-compiler-cfg.yaml
kubectl delete  -f "$DIR"/kotlin-compiler/kotlin-compiler.yaml

kubectl delete  -f "$DIR"/build-worker/build-worker-cfg.yaml
kubectl delete  -f "$DIR"/build-worker/build-worker.yaml

kubectl delete  -f "$DIR"/tock-studio.ing.yaml
