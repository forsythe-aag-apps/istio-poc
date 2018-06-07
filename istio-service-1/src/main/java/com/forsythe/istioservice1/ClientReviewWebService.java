package com.forsythe.istioservice1;

import org.apache.kafka.clients.producer.ProducerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.requestreply.ReplyingKafkaTemplate;
import org.springframework.kafka.requestreply.RequestReplyFuture;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.concurrent.ExecutionException;

@RestController
public class ClientReviewWebService {
    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private ReplyingKafkaTemplate<String, String, String> template;

    @RequestMapping("/client/{clientId}")
    public String clientUpdate(@PathVariable String clientId) {
        return restTemplate.getForObject(String.format("http://istio-service-2:8080/client/%s", clientId), String.class);
    }

    @RequestMapping("/kafka-client/{clientId}")
    public String kafkaClientUpdate(@PathVariable String clientId) throws ExecutionException, InterruptedException {
        RequestReplyFuture<String, String, String> replyFuture = template.sendAndReceive(new ProducerRecord<>("kRequests", clientId));
        return replyFuture.get().value();
    }

    @RequestMapping("/")
    public String clientUpdate() {
        return "Index Page";
    }
}
