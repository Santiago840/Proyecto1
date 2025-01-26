FROM php:8.2-apache

# Instalar extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar Composer globalmente
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar configuración personalizada de PHP
COPY php.ini /usr/local/etc/php/

# Configurar permisos y directorio de Laravel
RUN mkdir -p /var/www/html/principal && \
    chown -R www-data:www-data /var/www/html/principal && \
    echo "<Directory /var/www/html/>\n Options Indexes FollowSymLinks\n AllowOverride All\n Require all granted\n</Directory>" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

WORKDIR /var/www/html/principal
