#!/bin/bash



# Move to app directory and run required Symfony commands on each start
cd /app || exit 1

echo "[startup] Preparing writable directories..."
mkdir -p /app/var/cache /app/var/log /app/var/run /app/storage /app/config/jwt || true
chmod -R ugo+rw /app/var /app/storage /app/config/jwt || true

echo "[startup] Generating JWT keypair (idempotent)..."
php bin/console lexik:jwt:generate-keypair --overwrite -n || echo "[warn] JWT keypair generation failed"

echo "[startup] Warming up cache (dumps translations)..."
php bin/console cache:warmup || echo "[warn] cache:warmup failed"

echo "[startup] Installing importmap packages..."
php bin/console importmap:install || echo "[warn] importmap:install failed"

echo "[startup] Compiling asset map..."
php bin/console asset-map:compile || echo "[warn] asset-map:compile failed"

# Start supervisor
supervisord -c /etc/supervisord.conf -n
