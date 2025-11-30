# Imagen base con PHP y Apache
FROM php:8.2-apache

# Instalar extensiones necesarias para el proyecto (conexión a MySQL)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# --- INICIO DE CONFIGURACIÓN PARA PRUEBAS (CI/CD) ---

# 1. Instalar dependencias de compilación y utilidades
# ADVERTENCIA: Se añaden autoconf y build-essential para que PECL pueda compilar Xdebug
RUN apt-get update && apt-get install -y \
    wget \
    git \
    libxml2-dev \
    autoconf \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalar Xdebug y habilitarlo (necesario para generar el reporte de cobertura)
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# 3. Instalar PHPUnit (herramienta de pruebas)
RUN wget -q -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar \
    && chmod +x /usr/local/bin/phpunit

# --- FIN DE CONFIGURACIÓN PARA PRUEBAS ---

# Copiar los archivos del proyecto al contenedor
COPY . /var/www/html/

# Asignar permisos correctos
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 (para Apache)
EXPOSE 80