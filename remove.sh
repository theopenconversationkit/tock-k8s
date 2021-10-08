#!/bin/bash

F1()
{
    #cm
    k -n $1 delete -f configmap.yaml

    #mongo
    k -n $1 delete -f mongo-deployment.yaml
    k -n $1 delete -f mongo-service.yaml
    k -n $1 delete -f mongo2-deployment.yaml
    k -n $1 delete -f mongo2-service.yaml
    k -n $1 delete -f mongo3-deployment.yaml
    k -n $1 delete -f mongo3-service.yaml
    k -n $1 delete -f mongo-setup-deployment.yaml

    #build worker
    k -n $1 delete -f build-worker-deployment.yaml

    #duckling
    k -n $1 delete -f duckling-deployment.yaml
    k -n $1 delete -f duckling-service.yaml

    #kotlin
    k -n $1 delete -f kotlin-compiler-deployment.yaml
    k -n $1 delete -f kotlin-compiler-service.yaml

    #admin web
    k -n $1 delete -f admin-web-deployment.yaml
    k -n $1 delete -f admin-web-service.yaml

    # nlp_api
    k -n $1 delete -f nlp-api-deployment.yaml
    k -n $1 delete -f nlp-api-service.yaml

    # bot_api
    k -n $1 delete -f bot-api-deployment.yaml
    k -n $1 delete -f bot-api-service.yaml

    # ingress
    k -n $1 delete -f ingress.yaml


    k -n $1 delete -f mongo-setup-claim0-persistentvolumeclaim.yaml
    k -n $1 delete -f tockmongo-persistentvolumeclaim.yaml
    k -n $1 delete -f tockmongo2-persistentvolumeclaim.yaml
    k -n $1 delete -f tockmongo3-persistentvolumeclaim.yaml
}

if [[ -n "$1" ]]; then
  F1
else
  echo "Namespace is not defined !"
  echo "./remove.sh <namespace>"
fi