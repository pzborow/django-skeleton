# django-skeleton

Szablon [Copier](https://copier.readthedocs.io/) do projektów Django: DRF, Postgres, docker compose, opcjonalnie
Celery z Redisem i Elasticsearch, frontend w Nuxt z SSR. Testy jednostkowe i e2e, ruff i mypy (strict),
CI na GitHub Actions.


## Co trzeba mieć

- docker z compose,
- [uv](https://docs.astral.sh/uv/) (przez niego copier, `uvx copier`, a po wygenerowaniu robi `uv.lock`),
- make.


## Nowy projekt

    uvx copier copy --trust gh:pzborow/django-skeleton moj_projekt
    cd moj_projekt
    make build
    make up

`--trust` jest potrzebne, bo po wygenerowaniu copier puszcza `uv lock` w `backend/` (to jedyne zadanie, widać je
w `copier.yml`). Bez `--trust` copier odmówi.

Pytania:

| pytanie | domyślnie | co zmienia |
|---|---|---|
| `project_name` | Projekt | nagłówek README |
| `project_slug` | z nazwy: małe litery, bez polskich znaków, `_` zamiast spacji i `-` | nazwa w compose, obrazu, bazy i paczki w `pyproject.toml` (tylko `a-z`, `0-9`, `_`) |
| `python_version` | 3.13 | obraz `python:<wersja>-slim` i `requires-python` (Django 6.1 chce co najmniej 3.12) |
| `use_frontend` | tak | Nuxt (Vue z SSR) w `frontend/`, nginx przed całością (`/backend/` do Django) |
| `use_celery` | nie | worker, beat i Redis (broker, wyniki, cache) |
| `use_elasticsearch` | nie | ES 8.15, jeden węzeł bez zabezpieczeń, tylko do developmentu |

Odpowiedzi można dać od razu, np. `-d use_celery=true`, a `--defaults` bierze resztę domyślnych bez pytania.
Dalej README wygenerowanego projektu (`make help` też coś powie).


## Aktualizacja projektu do nowszej wersji szablonu

Copier zapisuje w projekcie `.copier-answers.yml` (wersja szablonu i odpowiedzi), więc w projekcie wystarczy

    uvx copier update --trust

Zmiany z szablonu nakładają się jak przy merge'u, konflikty zostają do rozwiązania w plikach. Lepiej mieć czysty stan w
gicie przed update'em. Lokalnego `.env` copier nie rusza: jeśli w `.env.example` doszły klucze, `make` odmówi startu i
wypisze, których brakuje (zmienione wartości trzeba wyłapać samemu, `diff .env.example .env`). Odpowiedź można przy
okazji zmienić, np. `-d use_celery=true` dokłada Celery do istniejącego projektu.

Konkretna wersja szablonu: `--vcs-ref <commit>`.


## Układ wygenerowanego projektu

    frontend/                Nuxt (przy use_frontend)
    backend/                 kod Django (projekt config), pyproject.toml, uv.lock, testy
    docker/dev/django/       Dockerfile i entrypoint.sh
    docker/dev/vue, nginx/   obrazy frontendu i nginx (przy use_frontend)
    compose.yaml
    .env.example             wzór lokalnego .env (make env)
    Makefile
    .github/workflows/ci.yml


## Sprawdzanie szablonu

`.github/workflows/test.yml` (CI tego repo) generuje projekt we wszystkich kombinacjach opcji i sprawdza
`docker compose config` i ruff, a skrajne kombinacje (nic i wszystko) buduje i puszcza `make lint`
(z mypy), `make test` i `make e2e`.
