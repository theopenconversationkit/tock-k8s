#!/bin/bash
./tock-studio/stop.sh
./mongo/stop.sh
kubectl delete -f namespaces/tock.namespace.json

