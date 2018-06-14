#!/bin/sh
# Operacje na serwerze w kontenerze
# na podstawie https://github.com/geo-data/openstreetmap-tiles-docker/blob/master/run.sh


help () {
    cat /usr/local/share/doc/run/help.txt
}


runserver () {
    migrate
    echo "Serwer deweloperski"
    cd /srv
    exec ./manage.py runserver 0:8000
}


makemigrations() {
    echo "Tworzenie migracji"
    cd /srv
    ./manage.py makemigrations
}


migrate() {
    echo "Migracja bazy"
    cd /srv
    ./manage.py migrate
}


runtest() {
    echo "Testy"
    cd /srv
    ./manage.py test
}


cli () {
    echo "Bash"
    cd /srv
    exec bash
}


if [ $# -eq 0 ] # bez argumentów
then
    if [ "$DEFAULT_RUN_COMMAND" ]
    then # komenda z DEFAULT_RUN_COMMAND
        ${DEFAULT_RUN_COMMAND}
    else # a jak nie ma, to pomoc
        help
    fi
else # komendy z argumentów, po kolei
    for arg
    do
        $arg;
    done
fi
