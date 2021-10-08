#!/bin/bash

function F1()
{
    k -n $1 apply -f tockmongo-persistentvolumeclaim.yaml
    k -n $1 apply -f tockmongo2-persistentvolumeclaim.yaml
    k -n $1 apply -f tockmongo3-persistentvolumeclaim.yaml

    #cm
    k -n $1 apply -f configmap.yaml

    #mongo
    k -n $1 apply -f mongo-deployment.yaml
    k -n $1 apply -f mongo-service.yaml
    k -n $1 apply -f mongo2-deployment.yaml
    k -n $1 apply -f mongo2-service.yaml
    k -n $1 apply -f mongo3-deployment.yaml
    k -n $1 apply -f mongo3-service.yaml
    k -n $1 apply -f mongo-setup-claim0-persistentvolumeclaim.yaml
    k -n $1 apply -f mongo-setup-deployment.yaml

    #build worker
    k -n $1 apply -f build-worker-deployment.yaml

    #duckling
    k -n $1 apply -f duckling-deployment.yaml
    k -n $1 apply -f duckling-service.yaml

    #kotlin
    k -n $1 apply -f kotlin-compiler-deployment.yaml
    k -n $1 apply -f kotlin-compiler-service.yaml

    #admin web
    k -n $1 apply -f admin-web-deployment.yaml
    k -n $1 apply -f admin-web-service.yaml

    # nlp_api
    k -n $1 apply -f nlp-api-deployment.yaml
    k -n $1 apply -f nlp-api-service.yaml

    # bot_api
    k -n $1 apply -f bot-api-deployment.yaml
    k -n $1 apply -f bot-api-service.yaml

    # ingress
    k -n $1 apply -f ingress.yaml
}

if [[ -n "$1" ]]; then
  F1
else
  echo "Namespace is not defined !"
  echo "./delpoy.sh <namespace>"
fi
