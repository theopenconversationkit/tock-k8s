#!/bin/bash
kubectl delete  -f mongo/mongo-cfg.yaml
kubectl delete  -f mongo/mongo.yaml
kubectl delete  -f mongo/mongo-setup.yaml
