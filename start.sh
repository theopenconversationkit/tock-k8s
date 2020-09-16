#!/bin/bash
set -e
./namespaces/init.sh
./mongo/start.sh
./wait_for.sh pod -ltype=mongo
./tock-studio/start.sh
./wait_for.sh pod -ltype=tock-studio
./bot-api/start.sh
./wait_for.sh pod -ltype=bot-api
kubectl get pods

printf "\n\n\nFirst adding this line in your '/etc/host' config\n\n    127.0.0.1 tock-studio bot-api\n\n\n"
printf "Open your browser \033[0;34mhttp://tock-studio\033[0m\n login    : \033[0;32madmin@app.com\033[0m\n password : \033[0;32mpassword\033[0m\n\n\n"
