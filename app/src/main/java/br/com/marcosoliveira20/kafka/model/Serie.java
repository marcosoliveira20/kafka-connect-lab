package br.com.marcosoliveira20.kafka.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor  // ESTE CONSTRUTOR É OBRIGATÓRIO PARA DESERIALIZAÇÃO
public class Serie {

    private int repeticoes;
    
    private int carga;

}
