package br.com.marcosoliveira20.kafka.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import br.com.marcosoliveira20.kafka.model.Treino;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class TreinoService {

    private static final Logger logger = LoggerFactory.getLogger(TreinoService.class);
    private final KafkaTemplate<String, Treino> kafkaTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final String TOPICO_KAFKA = "treinos";

    public TreinoService(KafkaTemplate<String, Treino> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publicarTreino(Treino treino) {
        try {
            kafkaTemplate.send(TOPICO_KAFKA, treino);
            logger.info("✅ Treino publicado no Kafka: {}", objectMapper.writeValueAsString(treino));
        } catch (Exception e) {
            logger.error("❌ Erro ao publicar treino no Kafka", e);
        }
    }
}
