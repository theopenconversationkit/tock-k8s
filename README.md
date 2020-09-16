# tock-k8s

Kubernetes implementation and resources for Tock.

## Deploying Tock Studio on localhost with kind
 
[kind](https://kind.sigs.k8s.io/) is a tool for running local Kubernetes clusters using Docker container “nodes”.

```sh
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64
chmod +x ./kind
./create-kind-cluster.sh
./start -with-kind.sh
```

Notice : All data are stored in "tock-mongo-data/" folder
All services are deployed with "tock" namespace

## Logs 

```
kubectl logs -f -l type=mongo
```

```
kubectl logs -f -l type=tock-studio
```

```
kubectl logs -f -l type=bot-api
```

## Stopping TOCK STUDIO

```
./stop-with-kind.sh
```

## Destroy your kind cluster

```
./kind delete cluster
```
