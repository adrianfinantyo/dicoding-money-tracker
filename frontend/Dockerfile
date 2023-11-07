FROM bitnami/php-fpm:7.4-prod

COPY . /app

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN composer install --no-dev --no-interaction --no-progress --optimize-autoloader --no-suggest

# Expose port 9000 and start php-fpm server
EXPOSE 9000