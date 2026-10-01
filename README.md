# django-skeleton

Szablon [Copier](https://copier.readthedocs.io/) do projektów Django (DRF, Postgres, docker compose).


## Użycie

Potrzebny [uv](https://docs.astral.sh/uv/) (albo copier zainstalowany inaczej, `pipx install copier`).

    uvx copier copy gh:pzborow/django-skeleton moj_projekt

Copier pyta o nazwę projektu, nazwę techniczną, wersję Pythona, o frontend (Nuxt z SSR, domyślnie tak), o Celery (z
Redisem) i o Elasticsearch (oba domyślnie bez). Odpowiedzi zapisuje w `.copier-answers.yml` w wygenerowanym projekcie,
dzięki temu potem da się w nim zrobić

    uvx copier update

i dociągnąć zmiany z nowszej wersji szablonu (konflikty jak przy merge'u). Konkretna wersja szablonu:
`--vcs-ref <commit>`.

Dalej README wygenerowanego projektu.


## Co jest w wygenerowanym projekcie

- Django z DRF i Postgresem w `compose.yaml` (wspólna część usług w `x-app`), kod w `backend/` (projekt `config`),
  obraz w `docker/dev/django/`,
- web czeka na zdrową bazę, potem `entrypoint.sh` puszcza migracje i zakłada konto admina (admin/admin),
- ustawienia z `docker/dev/django/.env` przez django-environ (baza z `DATABASE_URL`),
- Makefile z komendami (`make help`),
- pytest z pytest-django i ruff,
- przy `use_frontend` Nuxt z SSR w `frontend/` i nginx przed całością (`/backend/` do Django, reszta do Nuxta),
- przy `use_celery` worker i beat, Redis jako broker i cache (`config/celery.py`),
- przy `use_elasticsearch` Elasticsearch, jeden węzeł bez zabezpieczeń (tylko do developmentu).
