#!/bin/bash
./bot-api/stop.sh
./tock-studio/stop.sh
./mongo/stop.sh
kubectl delete -f namespaces/tock.namespace.json

