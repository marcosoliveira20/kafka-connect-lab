package br.com.marcosoliveira20.kafka.controller;

import br.com.marcosoliveira20.kafka.model.Treino;
import br.com.marcosoliveira20.kafka.service.TreinoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/treinos")
public class TreinoController {

    private final TreinoService treinoService;

    public TreinoController(TreinoService treinoService) {
        this.treinoService = treinoService;
    }

    @PostMapping
    public ResponseEntity<String> registrarTreino(@RequestBody Treino treino) {
        treinoService.publicarTreino(treino);
        return ResponseEntity.ok("Treino publicado no Kafka!");
    }
}
