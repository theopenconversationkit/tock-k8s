#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

kubectl delete -n tock -f "$DIR"/bot-admin/bot-admin-cfg.yaml
kubectl delete -n tock -f "$DIR"/bot-admin/bot-admin.yaml

kubectl delete -n tock -f "$DIR"/duckling/duckling-cfg.yaml
kubectl delete -n tock -f "$DIR"/duckling/duckling.yaml

kubectl delete -n tock -f "$DIR"/nlp-api/nlp-api-cfg.yaml
kubectl delete -n tock -f "$DIR"/nlp-api/nlp-api.yaml

kubectl delete -n tock -f "$DIR"/kotlin-compiler/kotlin-compiler-cfg.yaml
kubectl delete -n tock -f "$DIR"/kotlin-compiler/kotlin-compiler.yaml

kubectl delete -n tock -f "$DIR"/build-worker/build-worker-cfg.yaml
kubectl delete -n tock -f "$DIR"/build-worker/build-worker.yaml

kubectl delete -n tock -f "$DIR"/tock-studio.ing.yaml
