FROM php:7.4-apache

WORKDIR /var/www/html

COPY . /var/www/html

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    zlib1g-dev \
    libzip-dev \
    && docker-php-ext-install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run Composer to install dependencies in the project directory
RUN composer update

RUN composer install

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD ["apache2-foreground"]
