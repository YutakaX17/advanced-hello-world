# Developer guide

Clone all five repositories into the same parent directory. Each core package
is consumed by its assembler through an editable or local package reference.

## Backend

Create one virtual environment in `advanced-hello-world-be`, install the sibling
core with `pip install -e ../advanced-hello-world-be-core`, then install the
assembler with `pip install -e '.[dev]'`.

Run migrations and the server:

```bash
python manage.py migrate
python manage.py runserver
```

## Frontend

Install and build the frontend core first, then the assembler:

```bash
cd advanced-hello-world-fe-core
npm install
npm run build
cd ../advanced-hello-world-fe
npm install
npm run dev
```

Vite proxies `/api` to the Django server on port 8000.

## Change boundaries

- Persisted domain/API changes belong in the backend core.
- Django settings and deployment changes belong in the backend assembler.
- Reusable components and API client changes belong in the frontend core.
- Application assembly and Nginx changes belong in the frontend assembler.
- Cross-component deployment and end-to-end tests belong here.

