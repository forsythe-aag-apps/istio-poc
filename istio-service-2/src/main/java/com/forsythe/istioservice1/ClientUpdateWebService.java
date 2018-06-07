package com.forsythe.istioservice1;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ClientUpdateWebService {

    public static Logger logger = LoggerFactory.getLogger(ClientUpdateWebService.class);

    @RequestMapping("/client/{clientId}")
    public String clientUpdate(@PathVariable String clientId) {
        return clientId.equals("sirius") ? "approved" : "pending";
    }

    @RequestMapping("/")
    public String clientUpdate() {
        return "Index Page";
    }

    @KafkaListener(id = "server", topics = "kRequests")
    @SendTo("kReplies")
    public String handleClientUpdate(ConsumerRecord<String, String> cr) throws Exception {
        logger.info("Processing record", cr.value());
        String clientId = cr.value();
        return clientId.equals("sirius") ? "Event: " + cr.value() + " approved" : "pending";
    }
}
