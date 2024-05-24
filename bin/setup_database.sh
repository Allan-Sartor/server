#!/bin/bash

# Script para resetar o banco de dados e criar um novo

echo "Apagando banco de dados existente..."

bundle exec rails db:drop

echo "Criando novo banco de dados..."

bundle exec rails db:create

echo "Montando as migrações de desenvolvimento..."

bundle exec rails db:migrate

echo "Montando as migrações de testes..."

bundle exec rails db:migrate RAILS_ENV=test

echo "Banco de dados resetado com sucesso!"
