#!/usr/bin/env bash

gradle build -x test

docker build -t akalinovski/istio-service-1 ./istio-service-1
docker build -t akalinovski/istio-service-2 ./istio-service-2

docker push akalinovski/istio-service-1
docker push akalinovski/istio-service-2

kubectl apply -f <(istioctl kube-inject --debug -f ./istio-service-1/deployment/deployment.yml) -n istio-kafka-poc
kubectl apply -f <(istioctl kube-inject --debug -f ./istio-service-2/deployment/deployment.yml) -n istio-kafka-poc

kubectl apply -f ./istio-service-1/deployment/deployment.yml -n simple-kafka-poc
kubectl apply -f ./istio-service-2/deployment/deployment.yml -n simple-kafka-poc

