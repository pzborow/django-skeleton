# Szkielet projektu Django w dockerze

Szkielet do kopiowania na start nowego projektu. Obraz budowany z `images/django_app`, kod w `services/django_app`
montowany do kontenera w `/srv` (zmiany widać od razu, bez przebudowy obrazu).


## Start

Potrzebny docker i docker-compose.

    docker-compose up

Startuje baza i serwer deweloperski na http://localhost:8000 (migracje lecą przy starcie).


## Komendy w kontenerze

Obraz ma entrypoint `run` (`images/django_app/run.sh`), komendy można podawać po kolei:

    docker-compose run web help
    docker-compose run web makemigrations migrate
    docker-compose run web runtest
    docker-compose run web cli

Nowa komenda to nowa funkcja w `run.sh` (i linijka w `help.txt`).


## Znane problemy

Przy pierwszym starcie aplikacja może nie połączyć się z bazą, bo baza jeszcze wstaje. Ponowne `docker-compose up`
pomaga.
