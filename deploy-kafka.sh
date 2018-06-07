#!/usr/bin/env bash

kubectl apply -f ./kafka-deployment.yml -n simple-kafka-poc
kubectl apply -f ./fortio-deploy.yaml -n simple-kafka-poc

kubectl apply -f <(istioctl kube-inject --debug -f ./kafka-deployment.yml) -n istio-kafka-poc
kubectl apply -f <(istioctl kube-inject --debug -f ./fortio-deploy.yaml) -n istio-kafka-poc