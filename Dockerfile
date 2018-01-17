FROM php:7.1-apache

# User variables
ENV DIAMANTE_GIT_URL https://github.com/eltrino/diamantedesk-application.git

# Install needed software and dependencies
RUN DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install -qy \
git \
libicu-dev \
libmcrypt-dev \
libpng-dev \
libtidy-dev \
libxml2-dev \
npm && \
apt-get clean

# Install PHP extensions
RUN docker-php-ext-install \
gd \
intl \
mbstring \
mcrypt \
opcache \
pdo_mysql \
soap \
tidy \
zip

# Install and setup composer
RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer  

# Download sources
WORKDIR /var/www/diamante
RUN git clone $DIAMANTE_GIT_URL .

# Copy configs and scripts
# Workaround of Docker image filename length restriction
COPY config/diamante/parameters.yml app/config/parameters.yml
COPY config/php/php.ini /usr/local/etc/php/
COPY ./bootstrap.sh /var/www/diamante/bootstrap.sh
RUN chmod +x /var/www/diamante/bootstrap.sh

# Get dependencies for DiamanteDesk
RUN composer global require "fxp/composer-asset-plugin:~1.3"
RUN composer install --no-scripts
RUN ln -s /usr/bin/nodejs /usr/bin/node && \
npm install -g grunt-cli bower

# Setup project
RUN mkdir app/logs app/attachment
RUN chown -R www-data:www-data web app/attachments app/cache app/logs app/config/parameters.yml
RUN rm -rf /var/www/html && ln -s /var/www/diamante/web /var/www/html
RUN a2enmod rewrite

EXPOSE 80 8080
CMD ["/bin/bash", "bootstrap.sh"]