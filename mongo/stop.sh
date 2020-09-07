#!/bin/bash
kubectl delete -n tock -f mongo/mongo-cfg.yaml
kubectl delete -n tock -f mongo/mongo.yaml
kubectl delete -n tock -f mongo/mongo-setup.yaml
