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
zip

# Install and setup composer
RUN curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer  

# Download sources
COPY diamante /var/www/diamante
WORKDIR /var/www/diamante
# RUN git clone $DIAMANTE_GIT_URL .

# Copy configs and scripts
# Workaround of Docker image filename length restriction
COPY config/diamante/OroRequirements.php app/
COPY config/diamante/parameters.yml app/config/parameters.yml
COPY config/php/php.ini /usr/local/etc/php/
COPY config/apache2/apache2.conf /etc/apache2/apache2.conf

# COPY ./bootstrap.sh /var/www/diamante/bootstrap.sh
# RUN chmod +x /var/www/diamante/bootstrap.sh

# Get dependencies for DiamanteDesk
RUN composer install
RUN ln -s /usr/bin/nodejs /usr/bin/node && \
npm install -g grunt-cli bower

# Add docker user for shared folder
RUN useradd -g staff docker
RUN usermod -u 1000 docker

# Setup project
# RUN mkdir web/uploads/
# RUN chown -R www-data:www-data web app/attachment app/attachments app/cache app/config/parameters.yml app/logs
RUN rm -rf /var/www/html && ln -s /var/www/diamante/web /var/www/html
RUN a2enmod rewrite

EXPOSE 80 8080
CMD ["apache2-foreground"]
