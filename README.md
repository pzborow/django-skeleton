# Szkielet projektu Django w dockerze

Szkielet do kopiowania na start nowego projektu. Obraz budowany z `images/django_app`, kod w `services/django_app`
montowany do kontenera w `/srv` (zmiany widać od razu, bez przebudowy obrazu).


## Start

Potrzebny docker i docker-compose. Wolumen na bazę jest zewnętrzny (żeby `docker-compose down -v` go nie
skasował), trzeba go raz założyć:

    docker volume create data-postgresql
    docker-compose up

Startuje baza i serwer deweloperski na http://localhost:8000 (migracje lecą przy starcie).


## Komendy w kontenerze

Obraz ma entrypoint `run` (`images/django_app/run.sh`). Bez argumentów wykonuje komendę z `DEFAULT_RUN_COMMAND`
(w docker-compose to `runserver`), a z argumentami wykonuje je po kolei:

    docker-compose run web help
    docker-compose run web makemigrations migrate
    docker-compose run web runtest
    docker-compose run web cli

Nowa komenda to nowa funkcja w `run.sh` (i linijka w `help.txt`).

Do działającego kontenera wchodzi się skryptem `docker/bash`.


## Znane problemy

Przy pierwszym starcie aplikacja może nie połączyć się z bazą, bo baza jeszcze wstaje. Ponowne `docker-compose up`
pomaga.
