package br.com.marcosoliveira20.kafka.repository;


import br.com.marcosoliveira20.kafka.model.*;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface TreinoRepository extends MongoRepository<Treino, String> {
}
