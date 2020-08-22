#!/bin/bash

FAIL=${FAIL_LEVEL:=ERROR}
MANAGE_PATH=${GITHUB_WORKSPACE}/${APP_PATH}
REQS=${GITHUB_WORKSPACE}/${DEP_PATH}

echo -e "Path to manage.py set as: " $MANAGE_PATH
echo -e "Requirements path set as: " $REQS

if [[ "$ENV_TYPE" == "pipenv" ]]; then
    cd $REQS
    pip3 install pipenv
    PIPENV_IGNORE_VIRTUALENVS=1 pipenv install
    cd $MANAGE_PATH && PIPENV_IGNORE_VIRTUALENVS=1 pipenv run python3 manage.py check --deploy --fail-level ${FAIL} &> output.txt
fi
if [[ "$ENV_TYPE" == "venv" ]]; then
    pip install -r $REQS
    cd $MANAGE_PATH && python manage.py check --deploy --fail-level ${FAIL} &> output.txt
fi
if [[ -z "$ENV_TYPE" ]]; then
    echo "No virtual environment specified."
    pip install django
    cd $MANAGE_PATH && python manage.py check --deploy --fail-level ${FAIL} &> output.txt
fi

echo -e "\n--------- Django Security Check results ---------"
cat output.txt
