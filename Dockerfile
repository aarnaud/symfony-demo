FROM vincentchalamon/symfony
WORKDIR "/tmp"
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm /tmp/composer-setup.php
COPY composer.* /tmp/
RUN composer install --no-interaction --prefer-dist --no-scripts --no-autoloader
RUN rm -rf vendor
WORKDIR "/var/www"

