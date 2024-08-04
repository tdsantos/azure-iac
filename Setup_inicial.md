
# Setup Inicial para o Projeto "Olimpiadas TFTEC"

## Estrutura de Diretórios

```
azure-terraform/
├── modules/
│   ├── network/
│   ├── compute/
│   └── storage/
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   ├── roles/
│   │   ├── common/
│   │   ├── webserver/
│   │   └── database/
├── env/
│   ├── dev/
│   ├── staging/
│   └── prod/
├── scripts/
│   └── setup_azure_credentials.sh
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```

## Documentação

### 1. Instalação de Dependências

#### Instalar o Azure CLI

O Azure CLI é necessário para gerenciar os recursos Azure via linha de comando.

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

#### Instalar o Ansible

O Ansible é necessário para automatizar a configuração dos recursos após o provisionamento.

```bash
sudo apt-get update
sudo apt-get install -y ansible
```

#### Instalar o jq

O `jq` é utilizado para processar JSON no script.

```bash
sudo apt-get install -y jq
```

### 2. Fazer Login no Azure CLI

Antes de executar qualquer script, você precisa fazer login no Azure CLI para autenticar sua conta.

```bash
az login
```

### 3. Criar o Script para Configurar Credenciais do Azure

Crie o script `setup_azure_credentials.sh` na pasta `scripts` com o seguinte conteúdo:

```bash
#!/bin/bash

# Certifique-se de que jq está instalado
if ! [ -x "$(command -v jq)" ]; then
  echo 'Erro: jq não está instalado.' >&2
  echo 'Instale jq com: sudo apt-get install -y jq' >&2
  exit 1
fi

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

### 4. Dar Permissão de Execução ao Script

Dê permissão de execução ao script `setup_azure_credentials.sh`:

```bash
chmod +x scripts/setup_azure_credentials.sh
```

### 5. Executar o Script para Configurar Credenciais

Execute o script para configurar as credenciais do Azure:

```bash
./scripts/setup_azure_credentials.sh
```

### 6. Verificar a Configuração das Credenciais

Você pode verificar se as credenciais foram salvas corretamente:

```bash
cat ~/.azure/credentials
```

## Próximos Passos

Com essas etapas, você configurou o ambiente para usar Ansible e Azure CLI. Aqui estão os próximos passos que você pode seguir:

1. **Criar Playbooks do Ansible**: Crie playbooks para gerenciar seus recursos Azure.
2. **Criar Configurações do Terraform**: Configure o Terraform para provisionar recursos na Azure.
3. **Automatizar Tarefas com Ansible**: Use Ansible para automatizar a configuração e gerenciamento dos recursos provisionados pelo Terraform.