FROM mautic/mautic:latest

# Ensure only one MPM is loaded (prefork) for mod_php
RUN a2dismod mpm_event mpm_worker || true \
    && a2enmod mpm_prefork \
    && sed -ri 's/^\s*LoadModule\s+mpm_(event|worker)_module/#&/g' /etc/apache2/apache2.conf /etc/apache2/mods-available/*.load \
    && sed -ri 's/^\s*LoadModule\s+mpm_prefork_module/#&/g' /etc/apache2/apache2.conf /etc/apache2/mods-available/*.load \
    && echo 'LoadModule mpm_prefork_module /usr/lib/apache2/modules/mod_mpm_prefork.so' > /etc/apache2/mods-available/mpm_prefork.load

ARG MAUTIC_DB_HOST
ARG MAUTIC_DB_PORT
ARG MAUTIC_DB_USER
ARG MAUTIC_DB_PASSWORD
ARG MAUTIC_DB_NAME
ARG MAUTIC_TRUSTED_PROXIES
ARG MAUTIC_URL
ARG MAUTIC_ADMIN_EMAIL
ARG MAUTIC_ADMIN_PASSWORD

ENV MAUTIC_DB_HOST=$MAUTIC_DB_HOST
ENV MAUTIC_DB_PORT=$MAUTIC_DB_PORT
ENV MAUTIC_DB_USER=$MAUTIC_DB_USER
ENV MAUTIC_DB_PASSWORD=$MAUTIC_DB_PASSWORD
ENV MAUTIC_DB_NAME=$MAUTIC_DB_NAME
ENV MAUTIC_TRUSTED_PROXIES=$MAUTIC_TRUSTED_PROXIES
ENV MAUTIC_URL=$MAUTIC_URL
ENV MAUTIC_ADMIN_EMAIL=$MAUTIC_ADMIN_EMAIL
ENV MAUTIC_ADMIN_PASSWORD=$MAUTIC_ADMIN_PASSWORD
ENV PHP_INI_DATE_TIMEZONE='UTC'
