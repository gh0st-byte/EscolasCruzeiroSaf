# Sistema de Gerenciamento - Escolas do Cruzeiro

Sistema web para gerenciar os arquivos JSON das escolas de futebol do Cruzeiro.

Para iniciar o sistema:

### Backend (Servidor)

```bash
cd Backend
php -S localhost:8000
```

### Frontend (Interface)

Abra os arquivos HTML da pasta Frontend em um navegador ou use um servidor local:

```bash
npx serve .
```

## Funcionalidades

- **Autenticação**: Login seguro para administradores
- **Gerenciamento de Escolas**: CRUD completo para schools.json
- **Gerenciamento de Notícias**: CRUD para news.json e news_draft.json
- **Gerenciamento de Propostas**: Sistema de licenciamento com licenciadosProposta.json
- **Sistema de Tradução**: Suporte a múltiplos idiomas (PT/EN)
- **Formulários Públicos**: Aula experimental e licenciamento
- **Interface Responsiva**: Funciona em desktop e mobile
- **Validação de Dados**: Campos obrigatórios e tipos corretos

## Estrutura de Arquivos

```
EscolasDeFutebolDoCruzeiro/
├── Frontend/              # Interface do usuário
│   ├── index.html         # Página principal
│   ├── schools.html       # Página das escolas
│   ├── news.html          # Página de notícias
│   ├── benefits.html      # Página de benefícios
│   ├── formAulaWhatsapp.html    # Formulário aula experimental
│   ├── formLicenciado.html      # Formulário licenciamento
│   ├── css/               # Arquivos de estilo
│   ├── js/                # Scripts JavaScript (com tradutor)
│   ├── assets/            # Recursos estáticos
|   ├──sitemap.xml         # Recursos para motor de busca(mapeamento)
|   ├──site.webmanifest    # Recurso para navegador
|   └──robots.txt          # Instrução de direcionamento para o sitemap 
├── Backend/               # Servidor e dados
│   ├── admin/             # Sistema administrativo
│   ├── api/               # APIs REST
│   ├── data/Json/         # Arquivos de dados
│   └── config.php         # Configurações
└── README.md              # Este arquivo
```


## Como Usar

### Frontend (Usuários)

1. Acesse `Frontend/index.html` no navegador
2. Navegue pelas páginas:
   - **Home**: Página principal com mapa e notícias
   - **Escolas**: Lista filtrada das escolas
   - **Notícias**: Últimas notícias do Cruzeiro

### Backend (Administradores)

1. Acesse `Backend/admin/index.php` no navegador
2. Faça login com as credenciais
3. Use as abas para gerenciar:
   - **Escolas**: Dados completos das escolas
   - **Escolas não encontradas**: Endereços com problemas
   - **Notícias**: Gerenciar notícias publicadas
   - **Rascunhos**: Gerenciar rascunhos de notícias
   - **Usuários**: Gerenciar usuários do sistema
   - **Propostas**: Gerenciar propostas de licenciamento

### Operações Disponíveis

- **Adicionar**: Novos registros
- **Editar**: Modificar registros existentes
- **Deletar**: Remover registros (com confirmação)

## Principais Estruturas de Dados Utilizados

### schools.json

```json
{
  "lat": -19.9227318,
  "lng": -43.9450948,
  "nome": "Belo Horizonte – Castelo/MG",
  "endereco": "Rua original...",
  "endereco_encontrado": "Endereço processado...",
  "telefone": "(31) 99878-6291",
  "whatsapp": "https://api.whatsapp.com/send/?phone=...",
  "instagram": "@escoladocruzeirocastelo",
  "instagram_url": "http://instagram.com/...",
  "region": "Brasil",
  "estado": "MG"
}
```

### news.json

```json
{
  "title": "Nova categoria nas Escolas",
   "subtitle": "Futebol feminino ganha espaço no projeto educacional",
   "dayWeek": "Segunda-feira",
   "date": "07",
   "month": "Janeiro",
   "content": "As Escolas do Cruzeiro lançaram categoria de futebol feminino, oferecendo oportunidades iguais para meninas interessadas no esporte. A iniciativa conta com estrutura profissional e treinadoras especializadas. O projeto visa desenvolver talentos femininos e promover igualdade de gênero no ambiente esportivo.",
   "1-image_URL": "https:\/\/images.pexels.com\/photos\/1171084\/pexels-photo-1171084.jpeg"
}
```

### licenciadosProposta.json

```json

{
   "id": 1,
   "name": "Licenciado 2",
   "email": "licenciado2@example.com",
   "whatsapp": "+1234567891",
   "cidade de interesse": "Cidade Exemplo 2",
   "bairro de interesse": "Bairro Exemplo 2",
   "estado de interesse": "Estado Exemplo 2",
   "experiencia com futebol": "Empresário do esporte",
   "capital disponível": "R$ 60.000,00",
   "mensagem": "Estou interessado em abrir uma unidade da escola de futebol.",
   "status": "Em análise",
   "timestamp": "2025-10-15 14:23:11"
}
```

## Instalação no AWS Lightsail

### 1. Configuração do Servidor

```bash
# Conectar via SSH
ssh -i sua-chave.pem ubuntu@seu-ip-lightsail

# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install apache2 php libapache2-mod-php php-json php-mbstring php-curl -y

# Instalar ModSecurity
sudo apt install libapache2-mod-security2 modsecurity-crs -y
sudo a2enmod security2
sudo a2enmod rewrite
```

### 2. Configurar ModSecurity

```bash
# Ativar ModSecurity
sudo cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
sudo sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf

# Ativar OWASP Core Rules
sudo ln -s /usr/share/modsecurity-crs /etc/modsecurity/
echo 'Include /etc/modsecurity/modsecurity-crs/crs-setup.conf' | sudo tee -a /etc/apache2/mods-enabled/security2.conf
echo 'Include /etc/modsecurity/modsecurity-crs/rules/*.conf' | sudo tee -a /etc/apache2/mods-enabled/security2.conf
```

### 3. Deploy da Aplicação

```bash
# Clonar repositório
cd /var/www/html
sudo git clone https://github.com/seu-usuario/EscolasDeFutebolDoCruzeiro.git .

# Configurar permissões
sudo chown -R www-data:www-data Backend/data/Json/
sudo chmod -R 755 Backend/data/Json/

# Configurar variáveis de ambiente
sudo cp .env.example .env
sudo nano .env  # Editar credenciais
```

### 4. Configurar SSL (HTTPS)

```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-apache -y

# Obter certificado SSL
sudo certbot --apache -d escolasdocruzeiro.com
```

### 5. Configurar Virtual Host

```apache
# /etc/apache2/sites-available/cruzeiro.conf
<VirtualHost *:80>
    ServerName escolasdocruzeiro.com.br
    DocumentRoot /var/www/html
  
    # ModSecurity
    SecRuleEngine On
  
    # Redirecionar para HTTPS
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
</VirtualHost>

<VirtualHost *:443>
    ServerName escolasdocruzeiro.com.br
    DocumentRoot /var/www/html
  
    # SSL
    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/escolasdocruzeiro.com/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/escolasdocruzeiro.com/privkey.pem
  
    # ModSecurity
    SecRuleEngine On
  
    # PHP
    DirectoryIndex index.php index.html
  
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

### 6. Ativar Site

```bash
sudo a2ensite cruzeiro.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
```

## Instalação Local (Desenvolvimento)

```bash
# 1. Iniciar o servidor
cd Backend
php -S localhost:8000

# 2. Acessar a aplicação
# Frontend: http://localhost:8000/
# Admin: http://localhost:8000/Backend/admin/
```

## Requisitos Técnicos

### Servidor (AWS Lightsail)

- **OS**: Ubuntu 20.04 LTS ou superior
- **PHP**: 7.4+ com extensões: json, mbstring, curl
- **Servidor Web**: Apache 2.4+ (recomendado) ou Nginx
- **ModSecurity**: 2.9+ (WAF - Web Application Firewall)
- **SSL/TLS**: Certificado Let's Encrypt
- **Memória**: Mínimo 1GB RAM
- **Armazenamento**: 20GB SSD

### Dependências do Sistema

```bash
# Pacotes essenciais
sudo apt update
sudo apt install apache2 php libapache2-mod-php php-json php-mbstring php-curl

# ModSecurity (Firewall de Aplicação Web)
sudo apt install libapache2-mod-security2 modsecurity-crs

# SSL/HTTPS
sudo apt install certbot python3-certbot-apache
```

### Permissões Necessárias

- Escrita na pasta `Backend/data/Json/`
- Execução de scripts PHP
- Acesso de leitura aos arquivos estáticos

## Interface

- Design moderno com cores do Cruzeiro
- Interface responsiva para mobile
- Ícones intuitivos para ações
- Confirmações para operações destrutivas
- Modal para edição inline

## Segurança

- Autenticação por sessão com CSRF protection
- Validação de dados no servidor
- Escape de HTML para prevenir XSS
- Proteção contra Path Traversal
- Headers de segurança configurados
- Sanitização de entrada de dados
- Confirmação para exclusões

### Configuração de Segurança

1. **ModSecurity (WAF)**: Firewall de aplicação web ativo

   - Proteção contra XSS, SQL Injection, Path Traversal
   - OWASP Core Rule Set habilitado
   - Monitoramento em tempo real
2. **SSL/TLS**: Certificado Let's Encrypt configurado

   - HTTPS obrigatório (redirecionamento automático)
   - Criptografia TLS 1.2+
3. **Variáveis de Ambiente**: Credenciais em `.env`

   - Senhas criptografadas
   - Tokens CSRF protegidos
4. **Firewall AWS**: Portas restritas

   - Apenas 80 (HTTP) e 443 (HTTPS) abertas
   - SSH restrito por IP
5. **Backup**: Dados protegidos

   - Arquivos JSON com backup automático
   - Versionamento no Git

## Arquitetura

### Frontend

- **Tecnologias**: HTML5, CSS3, JavaScript ES6+
- **Frameworks**: Bootstrap 5, Leaflet Maps
- **Responsivo**: Desktop, Tablet, Mobile

### Backend

- **Linguagem**: PHP 7.4+
- **Dados**: JSON files
- **API**: REST endpoints
- **Admin**: Interface web completa

## Monitoramento e Manutenção

### Logs do ModSecurity

```bash
# Verificar logs de segurança
sudo tail -f /var/log/apache2/modsec_audit.log

# Verificar ataques bloqueados
sudo grep "Access denied" /var/log/apache2/error.log
```

### Atualizações de Segurança

```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Atualizar regras ModSecurity
sudo apt update modsecurity-crs
sudo systemctl restart apache2

# Renovar certificado SSL (automático)
sudo certbot renew --dry-run
```

### Backup dos Dados

```bash
# Backup manual
sudo tar -czf backup-$(date +%Y%m%d).tar.gz Backend/data/Json/

# Backup automático (crontab)
0 2 * * * /usr/bin/tar -czf /backup/cruzeiro-$(date +\%Y\%m\%d).tar.gz /var/www/html/Backend/data/Json/
```

## Responsividade

O sistema se adapta automaticamente para:

- Desktop (1200px+)
- Tablet (768px - 1199px)
- Mobile (< 768px)

# Licenciamento

- **Desenvolvedor Reponsável:** Marco Túlio Paiva Repoles
- **Empresa:** &copy;Cruzeiro Esporte Clube - SAF
# EscolasCruzeiroSaf
