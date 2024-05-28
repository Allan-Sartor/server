#!/bin/bash

# Para garantir que o processo pare em caso de erro
set -e

# Script para montar o servidor e iniciar ele ao final do processo.

echo ===============================================
echo "Instalação das dependências"
echo =============================================== 

cd ../
rm -rf Gemfile.lock
bundle install

echo ===============================================
echo "Apagando banco de dados existente caso haja!"
echo =============================================== 

bundle exec rails db:drop

echo ===============================================
echo "Criando novo banco de dados..."
echo =============================================== 

bundle exec rails db:create

echo ===============================================
echo "Montando as migrações de desenvolvimento..."
echo ===============================================

bundle exec rails db:migrate

echo ===============================================
echo Rodando testes
echo ===============================================

bundle exec rspec

echo ===============================================
echo Iniciando servidor
echo ===============================================

bundle exec rails s -p 3001
