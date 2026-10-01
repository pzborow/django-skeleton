#!/bin/sh
# Start od zera jednym docker compose up: migracje, konto admina (dane z .env), potem właściwa komenda
set -e
python manage.py migrate --noinput
python manage.py createsuperuser --noinput 2>/dev/null || true  # przy kolejnym starcie już jest
exec "$@"
