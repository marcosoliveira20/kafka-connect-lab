package br.com.marcosoliveira20.kafka.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor  // ESTE CONSTRUTOR É OBRIGATÓRIO PARA DESERIALIZAÇÃO
public class Exercicio {

    private String nome;
    
    private List<Serie> series;

}
