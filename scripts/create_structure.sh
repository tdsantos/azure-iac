#!/bin/bash

# Criando a estrutura de diretórios
mkdir -p azure-terraform/{modules/{network,compute,storage},ansible/{inventory,playbooks,roles/{common,tasks,webserver,tasks,database,tasks}},env/{dev,staging,prod}}

# Criando arquivos vazios
touch azure-terraform/{main.tf,outputs.tf,providers.tf,variables.tf}

# Criando arquivos para cada módulo
for module in network compute storage; do
    touch azure-terraform/modules/$module/{main.tf,outputs.tf,variables.tf}
done

# Criando arquivos para cada ambiente
for env in dev staging prod; do
    touch azure-terraform/env/$env/{main.tf,backend.tf,outputs.tf,providers.tf,variables.tf}
done

# Criando arquivos para Ansible
cat <<EOL > azure-terraform/ansible/inventory/hosts.ini
[webservers]
web1 ansible_host=<IP_WEB1>
web2 ansible_host=<IP_WEB2>

[dbservers]
db1 ansible_host=<IP_DB1>
EOL

cat <<EOL > azure-terraform/ansible/playbooks/main.yml
- hosts: webservers
  roles:
    - common
    - webserver

- hosts: dbservers
  roles:
    - common
    - database
EOL

# Criando arquivos de roles
for role in common webserver database; do
    mkdir -p azure-terraform/ansible/roles/$role/tasks
    cat <<EOL > azure-terraform/ansible/roles/$role/tasks/main.yml
- name: Task for $role
  debug:
    msg: "This is a placeholder task for $role role"
EOL
done

# Substituindo os arquivos de tasks com conteúdo específico
cat <<EOL > azure-terraform/ansible/roles/common/tasks/main.yml
- name: Update and upgrade apt packages
  apt:
    update_cache: yes
    upgrade: dist
  become: yes
EOL

cat <<EOL > azure-terraform/ansible/roles/webserver/tasks/main.yml
- name: Install Nginx
  apt:
    name: nginx
    state: present
  become: yes

- name: Start Nginx
  service:
    name: nginx
    state: started
    enabled: true
  become: yes
EOL

cat <<EOL > azure-terraform/ansible/roles/database/tasks/main.yml
- name: Install MySQL
  apt:
    name: mysql-server
    state: present
  become: yes

- name: Start MySQL
  service:
    name: mysql
    state: started
    enabled: true
  become: yes
EOL

echo "Estrutura de pastas e arquivos criada com sucesso!"

