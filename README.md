# istio-poc
Istio PoC

This repository contains PoC for testing Istio with different scenarios. 
It contains two microservices - Istio Service 1 and Istio Service 2.

Istio Service 1 calls Istio Service 2 and send back the result.
There are two endpoints for that /client/{clientId} and /kafka-client/{clientId}. 

First endpoint for REST communication. The second for Kafka event-based communication.

In order to deploy this to kubernetes follow the steps:

Install istio to kubernetes:

Follow the instructions from this document https://istio.io/docs/setup/kubernetes/quick-start:

```
curl -L https://git.io/getLatestIstio | sh -
cd istio-0.8.0
kubectl apply -f install/kubernetes/istio-demo-auth.yaml
```

Then verify the installation:
```
kubectl get svc -n istio-system
kubectl get pods -n istio-system
```

Prepare the namespaces for PoC projects:

```
kubectl create ns istio-kafka-poc
kubectl create ns simple-kafka-poc
```

Then build and deploy the microservices:

```
sh ./build.sh
```

If you don't need to change the source code of the services you can comment parts for docker push as it's 
uses private repository access. Or you can change it to your own and modify deployment.yml files properly.

Make sure everything is up and running:

```
kubectl get pods -n istio-kafka-poc
kubectl get pods -n simple-kafka-poc
```

Then you can run and check the stress tests:

```
sh ./run-istio-load.sh > istio-load.txt
```

You can check the statistics for the responses

The same relates to the simple scenario (without Istio):

```
sh ./run-simple-load.sh > simple-load.txt
```

Now you can check and compare the statistics with Istio and without it for bot REST and Kafka event-base approaches:

| Communication Type | With Istio | Min Time (s) | Avg Time (s) | Max Time (s) |
|--------------------|------------|--------------|--------------|--------------|
| REST               | No         | 0.000587866  | 0.023438981  | 0.247927439  |
| Kafka              | No         | 0.014516621  | 0.13176966   | 0.548365149  |
| REST               | Yes        | 0.004040379  | 0.13176966   | 1.456135156  |
| Kafka              | Yes        | 0.021058695  | 0.19700191   | 0.579825844  |


