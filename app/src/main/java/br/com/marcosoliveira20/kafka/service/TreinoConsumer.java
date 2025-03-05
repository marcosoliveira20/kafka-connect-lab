package br.com.marcosoliveira20.kafka.service;

import br.com.marcosoliveira20.kafka.model.Treino;
import br.com.marcosoliveira20.kafka.repository.TreinoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class TreinoConsumer {

    private static final Logger logger = LoggerFactory.getLogger(TreinoConsumer.class);
    private final TreinoRepository treinoRepository;

    public TreinoConsumer(TreinoRepository treinoRepository) {
        this.treinoRepository = treinoRepository;
    }

    @KafkaListener(topics = "treinos", groupId = "grupo-treino")
    public void consumirTreino(Treino treino) {
        // treinoRepository.save(treino);
        // logger.info("✅ Treino salvo no MongoDB: {}", treino);
    }
}
