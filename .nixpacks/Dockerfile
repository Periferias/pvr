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
COPY . /app/.
RUN  mkdir -p /var/log/nginx && mkdir -p /var/cache/nginx
RUN  composer install --ignore-platform-reqs
RUN  npm ci

# build phase
# detalhas melhor quais pastas devem ser copiadas
COPY . /app/.
RUN  mkdir -p /etc/supervisor/conf.d/
RUN  cp /assets/worker-*.conf /etc/supervisor/conf.d/
RUN  cp /assets/supervisord.conf /etc/supervisord.conf
RUN  chmod +x /assets/start.sh





# start
COPY . /app

CMD ["/assets/start.sh"]

