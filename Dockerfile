FROM dunglas/frankenphp:1-php8.2 AS frankenphp_upstream

FROM frankenphp_upstream AS frankenphp_base

WORKDIR /srv/app

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    postgresql-client \
    acl \
    && docker-php-ext-install \
    pdo_pgsql \
    intl \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Persistent volume for uploads
RUN mkdir -p var public/uploads && chown -R www-data:www-data var public/uploads

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Entrypoint script
COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

# Prod stage
FROM frankenphp_base AS frankenphp_prod

ENV APP_ENV=prod
ENV CADDY_SERVER_NAME=:80

COPY . .

# Ce fichier est INDISPENSABLE pour que Symfony ne crashe pas au démarrage.
# Il définit des valeurs par défaut qui seront écrasées par tes variables Portainer.
RUN echo "APP_ENV=prod" > .env && \
    echo "DEFAULT_URI=https://portfolio-bts-sio.kaelian.dev" >> .env && \
    echo "DATABASE_URL=postgresql://portfolio:portfolio@db:5432/portfolio?serverVersion=16&charset=utf8" >> .env

RUN composer install --no-dev --optimize-autoloader --no-scripts

# Optimization: remove dump-env as we inject variables via Docker/Portainer

ENV PORT=80
EXPOSE 80
EXPOSE 443
EXPOSE 443/udp

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
