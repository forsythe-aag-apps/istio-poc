#!/usr/bin/env bash

FORTIO_POD=$(kubectl get pod -n istio-kafka-poc | grep fortio | awk '{ print $1 }')
kubectl exec -it $FORTIO_POD -n istio-kafka-poc  -c fortio /usr/local/bin/fortio -- load -c 100 -qps 0 -n 10000 -loglevel Warning http://istio-service-1:8080/client/forsythe
kubectl exec -it $FORTIO_POD -n istio-kafka-poc  -c fortio /usr/local/bin/fortio -- load -c 100 -qps 0 -n 10000 -loglevel Warning http://istio-service-1:8080/kafka-client/forsythe