#!/bin/sh -l

FAIL=${FAIL_LEVEL:=ERROR}
MANAGE_PATH=${GITHUB_WORKSPACE}/${APP_PATH}

echo -e "Path to manage.py set as: " $MANAGE_PATH

if [ -f "Pipfile" ]; then
    pip3 install pipenv
    pipenv install
    cd $MANAGE_PATH
    echo -e "Running in $(pwd)"
    pipenv run python manage.py check --deploy --fail-level ${FAIL}
else
    cd $MANAGE_PATH && python manage.py check --deploy --fail-level ${FAIL}
fi
