# Django Security Check

Helps you continuously monitor and fix common security vulnerabilities in your [Django](https://www.djangoproject.com/) application.

If you are thinking of using this action, congratulations. You're well on your way to building a secure Django project!

## Use this in your workflow

You can use this action in a workflow file to continuously run [Django's `check --deploy`](https://docs.djangoproject.com/en/3.0/ref/django-admin/#check) against your production Django application configuration. Here is an example workflow that runs Django Security Check on any `push` event to the `master` branch. See below for `env` instructions.

```yml
name: Django Security Check

on:
  push:
    branches:
      - master

env:
  FAIL_LEVEL: WARNING
  ENV_TYPE: venv
  DEP_PATH: app/requirements.txt
  APP_PATH: app/

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
      - name: Check out master
        uses: actions/checkout@master
        with:
          fetch-depth: 1
      - name: Scan Django settings for security issues
        uses: victoriadrake/django-security-check@master
```

### Setting the `env` variables

The `FAIL_LEVEL` environment variable is the minimum severity finding that will cause the check to fail. Choices are `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. If not set, it defaults to `ERROR`.

This action currently supports use of [Pipenv](https://pipenv.pypa.io/en/latest/) or [`venv`](https://docs.python.org/3/library/venv.html#module-venv).

If you are using Pipenv, set `ENV_TYPE: pipenv`. Set the `DEP_PATH` variable to point to the directory containing your `Pipfile`. For example, if you have `project-root/app/Pipfile`, set `DEP_PATH: app/`. If you have `project-root/Pipfile`, you can leave this unset.

If you are using `venv`, set `ENV_TYPE: venv` as above. Set the `DEP_PATH` variable to the path of your dependencies file from the root, including the file name, as above. This is usually called `requirements.txt`, but may be different in your application.

Set the `APP_PATH` to the location of your `manage.py` file. For example, if you have `project-root/application/manage.py`, then set `APP_PATH: application/`. If you have `project-root/manage.py`, you can leave this unset.

If you are not using a virtual environment, shame on you. This action will still try to help you by installing Django. Ensure you set `APP_PATH` to the directory of your `manage.py` file.

### Workflow customization

See full instructions for [Configuring and managing workflows](https://help.github.com/en/actions/configuring-and-managing-workflows).

For help editing the YAML file, see [Workflow syntax for GitHub Actions](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions).

## View results

Depending on what you've set as a `FAIL_LEVEL`, this action may return results without a failed check. For example, the default `ERROR` level may still return `WARNING` results, although the check is a pass. To fail the check on `WARNING` results, set `FAIL_LEVEL` to `WARNING`, `INFO`, or `DEBUG`.

Here is [an example of output from a check](https://github.com/victoriadrake/react-in-django/runs/786560881?check_suite_focus=true#step:4:49). Helpful instructions for remediation are provided in the output.
