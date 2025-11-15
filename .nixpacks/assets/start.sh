#!/bin/bash

# Transform the nginx configuration
node /assets/scripts/prestart.mjs /assets/nginx.template.conf /etc/nginx.conf

# Move to app directory and run required Symfony commands on each start
cd /app || exit 1

echo "[startup] Generating JWT keypair (idempotent)..."
php bin/console lexik:jwt:generate-keypair --overwrite -n || echo "[warn] JWT keypair generation failed"

echo "[startup] Installing importmap packages..."
php bin/console importmap:install || echo "[warn] importmap:install failed"

echo "[startup] Compiling asset map..."
php bin/console asset-map:compile || echo "[warn] asset-map:compile failed"

# Start supervisor
supervisord -c /etc/supervisord.conf -n
