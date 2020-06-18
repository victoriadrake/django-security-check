# Django Security Check

Helps you continuously monitor and fix common security vulnerabilities in your Django application.

## Use this in your workflow

You can use this action in a workflow file to run [Django's `check`](https://docs.djangoproject.com/en/3.0/ref/django-admin/#check) against your production Django application. Here is an example workflow that runs Django Security Check on any `push` event to the `master` branch:

```yml
name: Django Security Check

on:
  push:
    branches:
      - master

env:
  FAIL_LEVEL: WARNING

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

The `FAIL_LEVEL` environment variable is the minimum severity finding that will cause the check to fail. Choices are `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. If not set, it defaults to `ERROR`.

See full instructions for [Configuring and managing workflows](https://help.github.com/en/actions/configuring-and-managing-workflows).

For help editing the YAML file, see [Workflow syntax for GitHub Actions](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions).
