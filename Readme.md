# Vanilla kubernetes yaml for Tock basic deployment

## Description

These files are generated from Tock *docker-compose.yml* via **kompose** converter

## Configuration

 In *ingress.yaml* file, set the values of the **hostnames**

* FQDN for admin-web
* FQDN for bot-api
* FQDN for nlp-api

## Deployment of Tock

``
./deploy.sh <your-namespace>
``

## Removing Tock

``
./remove.sh <your-namespace>
``
