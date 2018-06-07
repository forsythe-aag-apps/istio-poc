#!/usr/bin/env bash

kubectl delete -f ./kafka-deployment.yml -n simple-kafka-poc || true
kubectl delete -f <(istioctl kube-inject --debug -f ./kafka-deployment.yml) -n istio-kafka-poc  || true