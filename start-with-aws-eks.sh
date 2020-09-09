#!/bin/bash
set -e

# Step 1 créer 1 cluster
# Step 2 créer un role pour gerer les nodegroup (https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html)

# TODO Test aws-cli config

aws eks --profile 801660838771 --region eu-west-1 update-kubeconfig --name tock --alias tock-aws

kubectl config use-context tock-aws

./start.sh