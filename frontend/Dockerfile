FROM php:7.4-apache

WORKDIR /var/www/html

COPY . /var/www/html

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    zlib1g-dev \
    libzip-dev \
    && docker-php-ext-install zip

EXPOSE 80

CMD ["apache2-foreground"]
