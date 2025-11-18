FROM ghcr.io/railwayapp/nixpacks:ubuntu-1745885067

ENTRYPOINT ["/bin/bash", "-l", "-c"]
WORKDIR /app/


COPY .nixpacks/nixpkgs-e24b4c09e963677b1beea49d411cd315a024ad3a.nix .nixpacks/nixpkgs-e24b4c09e963677b1beea49d411cd315a024ad3a.nix
RUN nix-env -if .nixpacks/nixpkgs-e24b4c09e963677b1beea49d411cd315a024ad3a.nix && nix-collect-garbage -d

COPY .nixpacks/assets /assets/
ARG NIXPACKS_METADATA PORT
ENV NIXPACKS_METADATA=$NIXPACKS_METADATA PORT=$PORT

# setup phase
# noop

# install phase
COPY *.json /app/
COPY *.lock /app/
RUN  mkdir -p /app/var/cache /app/var/log /app/var/run /app/storage /app/config/jwt /app/var/nginx
RUN  composer install --ignore-platform-reqs
RUN  npm ci

# build phase
# detalhas melhor quais pastas devem ser copiadas
COPY . /app/.
# Transform the nginx configuration
RUN node /assets/scripts/prestart.mjs /assets/nginx.template.conf /etc/nginx.conf
RUN  mkdir -p /etc/supervisor/conf.d/
RUN  cp /assets/worker-*.conf /etc/supervisor/conf.d/
RUN  cp /assets/supervisord.conf /etc/supervisord.conf
RUN  chmod +x /assets/start.sh





# start
COPY . /app
RUN chown -R www-data:www-data /app

USER www-data
CMD ["/assets/start.sh"]
