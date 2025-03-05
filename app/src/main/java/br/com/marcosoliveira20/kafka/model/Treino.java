package br.com.marcosoliveira20.kafka.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor  // ESTE CONSTRUTOR É OBRIGATÓRIO PARA DESERIALIZAÇÃO
@Document(collection = "treinos")
public class Treino {
    @Id
    private String id;
    private String data;
    private List<Exercicio> exercicios;

}
