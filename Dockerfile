# Imagen base con PHP y Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copiar los archivos del proyecto al contenedor
COPY . /var/www/html/

# Asignar permisos correctos
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 (para Apache)
EXPOSE 80