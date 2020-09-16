#!/bin/bash
set -e

# Step 1 créer 1 cluster
# Step 2 créer un role pour gerer les nodegroup (https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html)
# Step 3 Ajouter un role au node
#     kubectl label nodes xxx "tock.ai/type=tock"

# TODO Test aws-cli config

aws eks --profile 801660838771 --region eu-west-1 update-kubeconfig --name tock --alias tock-aws

kubectl config use-context tock-aws

kubectl get nodes --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | while read -r name; do command kubectl label nodes $name "tock.ai/type=tock" --overwrite; done

TARGET_PLATFORM=eks ./start.sh