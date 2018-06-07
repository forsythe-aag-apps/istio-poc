#!/usr/bin/env bash

kubectl delete -f <(istioctl kube-inject --debug -f ./istio-service-1/deployment/deployment.yml) -n istio-kafka-poc
kubectl delete -f <(istioctl kube-inject --debug -f ./istio-service-2/deployment/deployment.yml) -n istio-kafka-poc

kubectl delete -f ./istio-service-1/deployment/deployment.yml -n simple-kafka-poc
kubectl delete -f ./istio-service-2/deployment/deployment.yml -n simple-kafka-poc

