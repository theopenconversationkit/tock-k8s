# tock-k8s

Kubernetes implementation and resources for Tock.

## Deploying Tock Studio on localhost with kind
 
[kind](https://kind.sigs.k8s.io/) is a tool for running local Kubernetes clusters using Docker container “nodes”.

```sh
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64
chmod +x ./kind
```

## Cluster with nginx Ingress controller

See [Ingress](https://kind.sigs.k8s.io/docs/user/ingress/)

```
./kind create cluster --config=./kind-config/kind.config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.27.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.27.0/deploy/static/provider/baremetal/service-nodeport.yaml
kubectl patch deployments -n ingress-nginx nginx-ingress-controller -p '{"spec":{"template":{"spec":{"containers":[{"name":"nginx-ingress-controller","ports":[{"containerPort":80,"hostPort":80},{"containerPort":443,"hostPort":443}]}],"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}' 
```

## Deploying TOCK STUDIO

`./start.sh`

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
./stop.sh
```

## Destroy your kind cluster

```
./kind delete cluster
```
