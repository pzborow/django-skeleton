#!/bin/sh
# Start od zera jednym docker compose up: migracje, konto admina (dane z .env), potem właściwa komenda
set -e
python manage.py migrate --noinput
# admin tylko za pierwszym razem, każdy inny błąd ma przerwać start
if ! python manage.py shell -c "import os; from django.contrib.auth import get_user_model; \
exit(not get_user_model().objects.filter(username=os.environ['DJANGO_SUPERUSER_USERNAME']).exists())"; then
    python manage.py createsuperuser --noinput
fi
exec "$@"
