#!/bin/bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install -y apache2 php libapache2-mod-php php-json php-mbstring php-curl git

# Instalar ModSecurity
sudo apt install -y libapache2-mod-security2 modsecurity-crs

# Ativar módulos
sudo a2enmod security2 rewrite ssl

# Deploy da aplicação
cd /var/www/html
sudo rm -rf *
sudo git clone https://github.com/gh0st-byte/EscolasDeFutebolDoCruzeiro.git .

# Configurar permissões
sudo chown -R www-data:www-data Backend/data/Json/
sudo chmod -R 755 Backend/data/Json/
