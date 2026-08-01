# Developer guide

Clone all seven repositories into the same parent directory, or run
`./scripts/bootstrap.sh` from the distribution checkout.

## Backend

Create one runtime virtual environment in `advanced-hello-world-be`, install the
assembler, then let its manifest installer register editable sibling modules:

```bash
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -e '.[dev]'
python -m advanced_hello_world.module_installer modules.json --local-root ..
```

Run migrations and the server:

```bash
python manage.py migrate
python manage.py runserver
```

## Frontend

Let the frontend manifest installer build core and selected features in order,
install them, and generate typed registration:

```bash
cd advanced-hello-world-fe
npm run modules:install -- --local-root ..
npm run dev
```

Vite proxies `/api` to the Django server on port 8000.

## Change boundaries

- Shared Django contracts and health behavior belong in the backend core.
- Persisted message/API behavior belongs in the backend messages module.
- Django settings and deployment changes belong in the backend assembler.
- Shared shell and module contracts belong in the frontend core.
- Message UI and API client changes belong in the frontend messages module.
- Application assembly and Nginx changes belong in the frontend assembler.
- Cross-component deployment and end-to-end tests belong here.
