# Treino Tracker

## 📌 Descrição
O **Treino Tracker** é um projeto que processa e armazena eventos de treinos utilizando **Kafka**, **MongoDB** e **S3**. A arquitetura é baseada em microsserviços e utiliza Kafka para o fluxo de mensagens entre os componentes.

## 🚀 Tecnologias Utilizadas
- **Docker & Docker Compose**: Gerenciamento de contêineres.
- **Apache Kafka**: Processamento assíncrono de mensagens.
- **MongoDB**: Banco de dados NoSQL para armazenar treinos.
- **S3 (MinIO)**: Armazenamento de dados estruturados para análise.
- **Shell Script**: Automação da execução e deploy.
- **Spring Boot**: Backend em Java para processar os eventos.

## 📂 Estrutura do Projeto
```
├── app/                     # Aplicação principal em Spring Boot
│   ├── src/                 # Código-fonte
│   ├── target/              # Build do projeto (JAR gerado)
│   ├── pom.xml              # Dependências do Maven
│   ├── mvnw                 # Maven Wrapper
│
├── connect-plugins/         # Conectores Kafka Connect
│
├# Scripts de automação
├conectores.sh        # Script para criação de conectores Kafka
├ deploy_treino_tracker.sh  # Script de deploy completo (inclui criação de conectores)
│
├Configuração de infraestrutura
├docker-compose.yml   # Definição dos serviços Docker
├Dockerfile           # Configuração da imagem da aplicação
│
├── README.md                # Este documento
```

## ▶️ Como Executar o Projeto

### 1️⃣ Clonar o Repositório
```sh
git clone https://github.com/seu-usuario/treino-tracker.git
cd treino-tracker
```

### 2️⃣ Construir e Subir os Contêineres
```sh
./deploy/deploy_treino_tracker.sh
```
Isso iniciará todos os serviços via **Docker Compose** e também executará a criação dos conectores automaticamente.

### 3️⃣ Verificar se os Serviços Estão Ativos
Para ver os containers rodando:
```sh
docker ps
```

Para ver logs da aplicação:
```sh
docker logs -f treino-tracker
```

### 4️⃣ Testar o Kafka
Consumir mensagens do tópico **treinos**:
```sh
docker exec -it KAFKA_CONTAINER_ID kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic treinos --from-beginning
```

### 5️⃣ Testar o MongoDB
Conectar ao MongoDB e verificar os treinos salvos:
```sh
docker exec -it MONGO_CONTAINER_ID mongosh
use treino-db
db.treinos.find().pretty()
```

### 6️⃣ Testar o Armazenamento S3 (MinIO)
Acesse o MinIO pelo navegador:
```
http://localhost:9000
```
Login padrão:
- **Usuário:** `admin`
- **Senha:** `admin123`

Verifique os arquivos dentro do bucket `data-lake`.

## 🛠️ Debug e Problemas Comuns
- **Kafka não está recebendo mensagens?** Verifique os logs:
  ```sh
  docker logs -f kafka
  ```
- **MongoDB sem registros?** Confirme se o conector Kafka → MongoDB está rodando:
  ```sh
  curl -X GET http://localhost:8083/connectors/mongodb-sink/status
  ```
- **S3 não está armazenando os arquivos?** Verifique o conector:
  ```sh
  curl -X GET http://localhost:8083/connectors/s3-sink/status
  ```

Se precisar de ajuda, abra uma issue no repositório! 🚀

