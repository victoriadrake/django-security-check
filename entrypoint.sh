#!/bin/sh -l

if [ -f "Pipfile" ]; then
    pip3 install pipenv
    pipenv run python manage.py check --deploy
else
    python manage.py check --deploy
fi
