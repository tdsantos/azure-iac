
# Setup Inicial

Este documento descreve os passos necessários para configurar o ambiente Azure para o projeto `olimpiadas tftec`.

## Requisitos

- Azure CLI
- Ansible
- jq

## Instalação

### 1. Instalar o Azure CLI

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### 2. Instalar o Ansible

```bash
pip install --upgrade ansible
```

### 3. Instalar o jq

```bash
sudo apt-get install jq
```

## Configuração do Ambiente

### 1. Autenticação no Azure

Faça login na sua conta Azure:

```bash
az login
```

Defina a assinatura que será utilizada:

```bash
az account set --subscription "Azure subscription 1"
```

### 2. Configurar as Credenciais do Azure para o Ansible

Crie um principal de serviço para o Ansible:

```bash
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
```

### 3. Criar Resource Group

Crie um playbook Ansible para criar o Resource Group:

```yaml
---
- name: Create Azure Resource Group using Azure CLI
  hosts: localhost
  tasks:
    - name: Create resource group
      command: >
        az group create
        --name rg-olimpiadas
        --location eastus
        --tags Ambiente=Olimpiadas
      register: rg

    - name: Display resource group info
      debug:
        var: rg.stdout_lines
```

Execute o playbook:

```bash
ansible-playbook create_resource_group_cli.yml -vvv
```

### 4. Criar Virtual Network (VNet) e Subnets

Crie um playbook Ansible para criar a VNet e as subnets:

```yaml
---
- name: Create Azure Virtual Network and Subnets using Azure CLI
  hosts: localhost
  tasks:
    - name: Create virtual network
      command: >
        az network vnet create
        --name vnet-olimpiadas
        --resource-group rg-olimpiadas
        --address-prefix 10.0.0.0/16
        --tags Ambiente=Olimpiadas
      register: vnet

    - name: Create subnet 01
      command: >
        az network vnet subnet create
        --resource-group rg-olimpiadas
        --vnet-name vnet-olimpiadas
        --name sub-olimpiadas01
        --address-prefix 10.0.1.0/24
      register: subnet01

    - name: Create subnet 02
      command: >
        az network vnet subnet create
        --resource-group rg-olimpiadas
        --vnet-name vnet-olimpiadas
        --name sub-olimpiadas02
        --address-prefix 10.0.2.0/24
      register: subnet02

    - name: Create Network Security Group
      command: >
        az network nsg create
        --resource-group rg-olimpiadas
        --name nsg-olimpiadas
        --location eastus
        --tags Ambiente=Olimpiadas
      register: nsg

    - name: Display virtual network info
      debug:
        var: vnet.stdout_lines

    - name: Display subnet 01 info
      debug:
        var: subnet01.stdout_lines

    - name: Display subnet 02 info
      debug:
        var: subnet02.stdout_lines

    - name: Display NSG info
      debug:
        var: nsg.stdout_lines
```

Execute o playbook:

```bash
ansible-playbook create_vnet_subnets.yml -vvv
```

## Estrutura de Diretórios

```plaintext
azure-terraform/
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbooks/
│   │   ├── create_resource_group_cli.yml
│   │   ├── create_vnet_subnets.yml
│   ├── roles/
│   │   ├── common/
│   │   ├── webserver/
│   │   └── database/
├── scripts/
│   └── setup_azure_credentials.sh
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```

## Autor

Thiago dos Santos  
Email: tdsantos.cloud@gmail.com  
LinkedIn: [https://www.linkedin.com/in/tdsantos1981/](https://www.linkedin.com/in/tdsantos1981/)