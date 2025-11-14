# django-skeleton

Szablon [Copier](https://copier.readthedocs.io/) do projektów Django (DRF, Postgres, docker compose).


## Użycie

Potrzebny [uv](https://docs.astral.sh/uv/) (albo copier zainstalowany inaczej, `pipx install copier`).

    uvx copier copy gh:pzborow/django-skeleton moj_projekt

Copier pyta o nazwę projektu, nazwę techniczną, wersję Pythona i o frontend (Nuxt z SSR, domyślnie tak). Odpowiedzi
zapisuje w `.copier-answers.yml` w wygenerowanym projekcie, dzięki temu potem da się w nim zrobić

    uvx copier update

i dociągnąć zmiany z nowszej wersji szablonu (konflikty jak przy merge'u). Konkretna wersja szablonu:
`--vcs-ref <commit>`.

Dalej README wygenerowanego projektu.


## Co jest w wygenerowanym projekcie

- Django z DRF i Postgresem w docker compose, kod w `backend/` (projekt `config`), obraz w `docker/dev/django/`,
- ustawienia z `docker/dev/django/.env` przez django-environ (baza z `DATABASE_URL`),
- Makefile z komendami (`make help`),
- pytest z pytest-django i ruff,
- przy `use_frontend` Nuxt z SSR w `frontend/` i nginx przed całością (`/backend/` do Django, reszta do Nuxta).
