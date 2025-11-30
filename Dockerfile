# Dockerfile modificado (Raíz del proyecto)
# ... (código existente)
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# --- PASO 1: INSTALAR HERRAMIENTAS DE PRUEBA (PHPUnit y Xdebug) ---
# Instalar utilidades (wget, git)
RUN apt-get update && apt-get install -y \
    wget \
    git \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar Xdebug (necesario para generar el reporte de cobertura)
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Instalar PHPUnit (herramienta de pruebas)
RUN wget -q -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar \
    && chmod +x /usr/local/bin/phpunit
# --- FIN DE INSTALACIÓN DE PRUEBAS ---

# ... (código existente: COPY . /var/www/html/, etc.)