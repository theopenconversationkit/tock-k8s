#!/bin/bash
kubectl config use-context tock-aws

TARGET_PLATFORM=eks ./stop.sh