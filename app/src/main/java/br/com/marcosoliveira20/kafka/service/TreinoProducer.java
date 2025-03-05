package br.com.marcosoliveira20.kafka.service;

import br.com.marcosoliveira20.kafka.model.*;

import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TreinoProducer {

    private static final String TOPICO = "treinos";

    @Autowired
    private KafkaTemplate<String, Treino> kafkaTemplate;

    public void enviarTreino(Treino treino) {
        kafkaTemplate.send(TOPICO, treino);
    }
}