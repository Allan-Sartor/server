#!/bin/bash

# Script para resetar o banco de dados e criar um novo

echo "Apagando banco de dados existente..."

bundle exec rails db:drop

echo "Criando novo banco de dados..."

bundle exec rails db:create

echo "Montando as migrações..."

bundle exec rails db:migrate

echo "Banco de dados resetado com sucesso!"
