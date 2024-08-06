# Olimpíadas Azure TFTEC 2024

Repositório para armazenar o projeto das Olimpíadas TFTEC 2024

```markdown
# Terraform Azure Infrastructure Project

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-623CE4?style=for-the-badge&logo=terraform)
![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoft-azure)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

![Terraform Logo](https://www.terraform.io/assets/images/og-image-8b3e4f7d.png)

## Overview

Este projeto utiliza o Terraform para gerenciar e provisionar a infraestrutura no Azure. Ele inclui a configuração de recursos como grupos de recursos, redes virtuais, sub-redes, interfaces de rede e máquinas virtuais.

## Estrutura do Projeto

```plaintext
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vm/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
└── README.md
```

## Pré-requisitos

- Terraform v1.0+
- Azure CLI
- Conta no Azure

## Configuração

### 1. Configurar Azure CLI

```sh
az login
```

### 2. Inicializar o Terraform

```sh
terraform init
```

### 3. Configurar Variáveis

Edite o arquivo `terraform.tfvars` com os valores apropriados:

```hcl
resource_group_name = "rg-olimpiadas"
location            = "eastus"
vnet_name           = "vnet-olimpiadas"
address_space       = ["10.0.0.0/16"]
subnet01_name       = "sub-olimpiadas01"
subnet01_prefix     = "10.0.1.0/24"
subnet02_name       = "sub-olimpiadas02"
subnet02_prefix     = "10.0.2.0/24"
nsg_name            = "nsg-olimpiadas"
tags = {
  Environment = "Test"
  Project     = "Olimpiadas"
}
vm_windows_name     = "vm-windows"
vm_windows_username = "user_name"
vm_windows_password = "your_password"
vm_linux_name       = "vm-linux"
vm_linux_username   = "user_name"
vm_linux_ssh_key    = "your_ssh_public_key"
```

### 4. Aplicar o Terraform

```sh
terraform apply
```

## Recursos Provisionados

- **Resource Group:** `rg-olimpiadas`
- **Virtual Network:** `vnet-olimpiadas`
- **Subnets:**
  - `sub-olimpiadas01`
  - `sub-olimpiadas02`
- **Network Security Group:** `nsg-olimpiadas`
- **Virtual Machines:**
  - Windows VM: `vm-windows`
  - Linux VM: `vm-linux`

## Outputs

Os principais outputs deste projeto incluem:

- ID do Grupo de Recursos
- Nome da Rede Virtual
- IDs das Subnets
- Endereços IP Públicos das VMs

## Limpeza

Para destruir a infraestrutura provisionada, execute:

```sh
terraform destroy
```

## Contribuição

Sinta-se à vontade para contribuir com este projeto enviando pull requests, reportando issues ou sugerindo melhorias.

## Licença

Este projeto é licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---