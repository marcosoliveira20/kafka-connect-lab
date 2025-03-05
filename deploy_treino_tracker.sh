#!/bin/bash

set -e  # Para o script caso algum comando falhe

echo "🚀 Iniciando o build e deploy do Treino Tracker..."

# Passo 1: Limpar e compilar o projeto Maven
echo "🛠️ Limpando e compilando o projeto..."
cd app && ./mvnw clean package && cd ..

# Passo 2: Remover containers antigos se existirem
echo "🗑️ Removendo containers antigos..."
docker-compose down

# Passo 3: Remover imagem antiga
echo "🔄 Removendo imagem antiga..."
docker rmi treino-tracker || true  # Evita erro se a imagem não existir

# Passo 4: Construir nova imagem Docker
echo "🐳 Construindo nova imagem Docker..."
docker build  --no-cache -t treino-tracker .

# Passo 5: Subir os serviços com Docker Compose
echo "🚀 Subindo os serviços com Docker Compose..."
docker-compose -f ./docker-compose.yml up --build -d

# Aguarde o Kafka Connect ficar pronto antes de criar os conectores
echo "⏳ Aguardando Kafka Connect iniciar..."
TIMER=90  
while [ $TIMER -gt 0 ]; do
  if curl -s http://localhost:8083/ | grep -q "connectors"; then
    echo -e "\n✅ Kafka Connect está pronto!"
    break
  fi
  echo -ne "⏳ Tempo restante para iniciar Kafka Connect: $TIMER segundos...\r"
  sleep 5
  TIMER=$((TIMER - 5))
done

echo -e "\n🚀 Criando Conectores no Kafka Connect..."
sleep 60

# Criando Conector S3 (MinIO)
echo "🔗 Criando conector S3 (MinIO)..."
curl -X POST -H "Content-Type: application/json" --data '{
    "name": "s3-sink",
    "config": {
        "connector.class": "io.confluent.connect.s3.S3SinkConnector",
        "tasks.max": "1",
        "topics": "treinos",
        "s3.bucket.name": "data-lake",
        "s3.region": "us-east-1",
        "store.url": "http://minio:9000",
        "aws.access.key.id": "admin",
        "aws.secret.access.key": "admin123",
        "storage.class": "io.confluent.connect.s3.storage.S3Storage",
        "format.class": "io.confluent.connect.s3.format.json.JsonFormat",
        "schema.generator.class": "io.confluent.connect.storage.hive.schema.DefaultSchemaGenerator",
        "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
        "flush.size": "1"
    }
}' http://localhost:8083/connectors || echo "⚠️ Erro ao criar o conector S3!"


sleep 5

# Criando Conector MongoDB
echo "🔗 Criando conector MongoDB..."
curl -X POST -H "Content-Type: application/json" --data '{
    "name": "mongodb-sink",
    "config": {
        "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
        "tasks.max": "1",
        "topics": "treinos",
        "connection.uri": "mongodb://admin:admin123@mongodb:27017",
        "database": "treino-db",
        "collection": "treinos",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": "false"
    }
}' http://localhost:8083/connectors || echo "⚠️ Erro ao criar o conector MongoDB!"



echo "✅ Todos os conectores foram criados com sucesso!"