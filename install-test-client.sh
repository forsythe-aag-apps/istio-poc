#!/usr/bin/env bash

kubectl apply -f <(istioctl kube-inject --debug -f ./test-client.yml)