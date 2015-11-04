FROM php:5.6-apache

# Install needed software and dependencies
RUN DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install -qy \
git \
libicu-dev \
libmcrypt-dev \
libpng-dev \
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
zip && \
pecl install xdebug

# Install and setup composer
RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer  

# Download sources
COPY ./src /var/www/diamante
WORKDIR /var/www/diamante

# Copy configs and scripts
# Workaround of filename length restriction inside Docker image
COPY config/diamante/OroRequirements.php app/
COPY config/diamante/parameters.yml app/config/parameters.yml
COPY config/php/php.ini /usr/local/etc/php/

COPY ./bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

# Get dependencies for DiamanteDesk
RUN ln -s /usr/bin/nodejs /usr/bin/node && \
npm install -g grunt-cli bower
RUN rm -rf vendor
RUN composer install

# Setup project
RUN rm -rf /var/www/html && ln -s /var/www/diamante/web /var/www/html
RUN a2enmod rewrite

EXPOSE 80 8080
CMD ["/bootstrap.sh"]
