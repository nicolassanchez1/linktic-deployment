#!/bin/bash

echo "🚀 Iniciando el despliegue del ecosistema LinkTic..."

clone_if_not_exists() {
  if [ ! -d "$2" ]; then
    echo "⬇️  Clonando $2..."
    git clone "$1" "$2"
  else
    echo "✅ $2 ya existe, actualizando..."
    cd "$2" && git pull && cd ..
  fi
}

clone_if_not_exists "https://github.com/nicolassanchez1/api-gateway.git" "api-gateway"
clone_if_not_exists "https://github.com/nicolassanchez1/auth-service.git" "auth-service"
clone_if_not_exists "https://github.com/nicolassanchez1/product-service.git" "product-service"
clone_if_not_exists "https://github.com/nicolassanchez1/order-service.git" "order-service"

echo "🐳 Construyendo y levantando contenedores con Docker Compose..."
docker-compose up --build

echo "✅ ¡Ecosistema en línea!"