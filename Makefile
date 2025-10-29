HELM_NS_OPTS ?= $(shell $(HELM_INSTALL) && echo --create-namespace)
HELM_OPTIONS ?=
HELM_INSTALL ?= false
HELM_UPGRADE ?= $(shell $(HELM_INSTALL) || echo diff) upgrade --install $(shell $(HELM_INSTALL) || echo -C 5)

TOCK_NAMESPACE ?= tock

MONGODB_OPERATOR_VERSION ?= master

mongodb-kubernetes-operator:
	git clone https://github.com/mongodb/mongodb-kubernetes-operator.git

deploy-mongodb-operator: mongodb-kubernetes-operator
	kubectl apply -k mongodb-kubernetes-operator/config/rbac --namespace operators
	kubectl apply -f mongodb-kubernetes-operator/config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
	kubectl apply -f mongodb-operator/

deploy-tock:
	# Deploy tock
	helm $(HELM_UPGRADE) tock charts/tock $(HELM_NS_OPTS) --namespace $(TOCK_NAMESPACE) $(HELM_OPTIONS)

clean:
	rm -rf mongodb-kubernetes-operator
