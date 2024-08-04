#!/bin/bash

# Obter ID da Assinatura
subscription_id=$(az account show --query id --output tsv)

# Obter ID do Locatário
tenant_id=$(az account show --query tenantId --output tsv)

# Criar um Principal de Serviço
sp=$(az ad sp create-for-rbac --name "http://my-ansible-sp" --role contributor --scopes /subscriptions/$subscription_id)

# Extrair appId e password do Principal de Serviço
client_id=$(echo $sp | jq -r '.appId')
client_secret=$(echo $sp | jq -r '.password')

# Criar o arquivo de credenciais
mkdir -p ~/.azure
cat <<EOL > ~/.azure/credentials
[default]
subscription_id=$subscription_id
client_id=$client_id
secret=$client_secret
tenant=$tenant_id
EOL

echo "Credenciais salvas em ~/.azure/credentials"
