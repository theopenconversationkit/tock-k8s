#!/bin/bash
kubectl config set-context tock \
 --namespace=tock \
 --cluster=kind-kind \
 --user=kind-kind

kubectl config use-context tock

./namespaces/init.sh
./mongo/start.sh
./wait_for.sh pod -ltype=mongo
./tock-studio/start.sh
./wait_for.sh pod -ltype=tock-studio
kubectl get pods

printf "\n\n\nFirst adding this line in your '/etc/host' config\n\n    127.0.0.1 tock-studio\n\n\n"
printf "Open your browser \033[0;34mhttp://tock-studio\033[0m\n login    : \033[0;32madmin@app.com\033[0m\n password : \033[0;32mpassword\033[0m\n\n\n"