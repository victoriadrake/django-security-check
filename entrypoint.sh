#!/bin/sh -l

FAIL=${FAIL_LEVEL:=ERROR}

if [ -f "Pipfile" ]; then
    pip3 install pipenv
    pipenv install
    pipenv run python manage.py check --deploy --fail-level ${FAIL}
else
    python manage.py check --deploy --fail-level ${FAIL}
fi
