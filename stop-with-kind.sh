#!/bin/bash
kubectl config use-context tock-kind

TARGET_PLATFORM=kind ./stop.sh