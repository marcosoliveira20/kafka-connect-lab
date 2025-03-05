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


sleep 5

# Criando Conector PostgreSQL
echo "🔗 Criando conector PostgreSQL..."
curl -X POST -H "Content-Type: application/json" --data '{
    "name": "postgres-sink",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": "1",
        "topics": "treinos",
        "connection.url": "jdbc:postgresql://postgres:5432/dw",
        "connection.user": "admin",
        "connection.password": "admin123",
        "auto.create": "false",
        "auto.evolve": "false",
        "insert.mode": "insert",
        "pk.mode": "none",
        "table.name.format": "treino",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": "false"
    }
}' http://localhost:8083/connectors || echo "⚠️ Erro ao criar o conector PostgreSQL!"

echo "✅ Todos os conectores foram criados com sucesso!"