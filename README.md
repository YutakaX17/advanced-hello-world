# Advanced Hello World

All-in-one distribution for a modular Django, React TypeScript, PostgreSQL, and
Docker learning application. Enter text in the centered form, save it through
the REST API, persist it in PostgreSQL, and receive SweetAlert2 confirmation.

## Repository family

| Repository                                                                         | Responsibility                                                    |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| [Backend core](https://github.com/YutakaX17/advanced-hello-world-be-core)          | Shared Django contracts, health endpoints, and migration history  |
| [Backend messages](https://github.com/YutakaX17/advanced-hello-world-be-messages)  | Message model, validation, serialization, and REST API             |
| [Backend assembler](https://github.com/YutakaX17/advanced-hello-world-be)          | Manifest-driven Django project and backend image                   |
| [Frontend core](https://github.com/YutakaX17/advanced-hello-world-fe-core)         | Shared React shell, layout, and typed module contracts             |
| [Frontend messages](https://github.com/YutakaX17/advanced-hello-world-fe-messages) | Message page, API client, feature styles, and confirmation         |
| [Frontend assembler](https://github.com/YutakaX17/advanced-hello-world-fe)         | Generated module registration, Vite application, and Nginx image  |
| [Distribution](https://github.com/YutakaX17/advanced-hello-world)                  | Workspace bootstrap, Compose, compatibility, docs, and E2E tests  |

```text
Browser → Nginx :8080 → Django :8000 → PostgreSQL :5432
             └────── /api proxy ──────┘
```

## Choose a setup

| Setup                  | Best for                                                  |
| ---------------------- | --------------------------------------------------------- |
| Released Docker images | Fastest evaluation and stable versioned deployment        |
| Docker source build    | Container and cross-repository integration development    |
| Fully native           | Direct debugging and fastest backend/frontend edit cycle  |
| Hybrid                 | Native Django and Vite with PostgreSQL isolated in Docker |

## Setup with released Docker images

Requirements:

- Git
- Docker Engine
- Docker Compose v2

```bash
git clone https://github.com/YutakaX17/advanced-hello-world.git
cd advanced-hello-world
cp .env.example .env
```

Edit `.env` and replace both placeholder secrets. Do not commit it. Start the
released images:

```bash
docker compose pull
docker compose up -d --wait
docker compose ps
```

Open <http://localhost:8080>. Verify services and logs:

```bash
curl http://localhost:8080/health
curl http://localhost:8080/api/v1/health/live
docker compose logs --since 10m backend
```

Stop without deleting PostgreSQL data:

```bash
docker compose down
```

Delete containers and saved database data only when intentional:

```bash
docker compose down --volumes
```

## Setup with Docker and local source

Clone all repositories as siblings:

```bash
mkdir advanced-hello-world-workspace
cd advanced-hello-world-workspace
git clone https://github.com/YutakaX17/advanced-hello-world-be-core.git
git clone https://github.com/YutakaX17/advanced-hello-world-be-messages.git
git clone https://github.com/YutakaX17/advanced-hello-world-be.git
git clone https://github.com/YutakaX17/advanced-hello-world-fe-core.git
git clone https://github.com/YutakaX17/advanced-hello-world-fe-messages.git
git clone https://github.com/YutakaX17/advanced-hello-world-fe.git
git clone https://github.com/YutakaX17/advanced-hello-world.git
cd advanced-hello-world
cp .env.example .env
```

Alternatively, clone only this distribution into an empty workspace and let the
bootstrap command clone and install all selected repositories:

```bash
./scripts/bootstrap.sh
```

The command is safe to rerun: it reuses existing Git repositories, refuses to
overwrite unrelated paths, creates the backend assembler's `.venv`, installs
editable backend modules, builds frontend modules, generates typed frontend
registration, and validates both manifests.

The development Compose file is an override and must be used with the base
file:

```bash
docker compose -f compose.yml -f compose.dev.yml up -d --build --wait
```

Rebuild after changing a core package or Dockerfile:

```bash
docker compose -f compose.yml -f compose.dev.yml build --no-cache backend frontend
docker compose -f compose.yml -f compose.dev.yml up -d --wait
```

Inspect or stop the development stack:

```bash
docker compose -f compose.yml -f compose.dev.yml logs -f
docker compose -f compose.yml -f compose.dev.yml down
```

## Fully native setup without Docker

Requirements:

- Git
- Python 3.12 or newer
- Node.js 22 and npm
- PostgreSQL 17

Clone the seven sibling repositories using the commands above, or run
`./scripts/bootstrap.sh`.

Create the database and role:

```sql
CREATE ROLE advanced_hello_world LOGIN PASSWORD 'local-development-password';
CREATE DATABASE advanced_hello_world OWNER advanced_hello_world;
```

Install and start the backend:

```bash
cd advanced-hello-world-be
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e '.[dev]'
python -m advanced_hello_world.module_installer modules.json --local-root ..

export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=advanced_hello_world
export POSTGRES_USER=advanced_hello_world
export POSTGRES_PASSWORD=local-development-password
export DJANGO_SECRET_KEY=local-development-only-key
export DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
export CORS_ALLOWED_ORIGINS=http://localhost:5173

python manage.py migrate
python manage.py runserver
```

In another terminal, install and start the frontend:

```bash
cd advanced-hello-world-fe
npm run modules:install -- --local-root ..
npm run dev
```

Open <http://localhost:5173>. Vite proxies `/api` to Django on port `8000`.

## Hybrid setup

Run PostgreSQL in Docker while Django and Vite run natively:

```bash
docker run --name advanced-hello-world-db \
  -e POSTGRES_DB=advanced_hello_world \
  -e POSTGRES_USER=advanced_hello_world \
  -e POSTGRES_PASSWORD=local-development-password \
  -p 5432:5432 \
  -v advanced-hello-world-db:/var/lib/postgresql/data \
  -d postgres:17.5-alpine
```

Then follow the native backend and frontend steps. Stop and restart PostgreSQL
without deleting its volume:

```bash
docker stop advanced-hello-world-db
docker start advanced-hello-world-db
```

## Testing

Run repository-specific unit and quality checks from each component README.
Run browser-to-database tests against the released Compose stack:

```bash
npm ci
npx playwright install --with-deps chromium
docker compose up -d --wait
npm run test:e2e
```

## Configuration

| Variable               | Purpose                           | Local default/example         |
| ---------------------- | --------------------------------- | ----------------------------- |
| `POSTGRES_DB`          | Database name                     | `advanced_hello_world`        |
| `POSTGRES_USER`        | Database role                     | `advanced_hello_world`        |
| `POSTGRES_PASSWORD`    | Database password                 | No safe production default    |
| `DJANGO_SECRET_KEY`    | Django cryptographic key          | No safe production default    |
| `DJANGO_ALLOWED_HOSTS` | Accepted host names               | `localhost,127.0.0.1,backend` |
| `CORS_ALLOWED_ORIGINS` | Browser origins allowed by Django | `http://localhost:8080`       |
| `BACKEND_IMAGE`        | Released backend image            | Versioned GHCR image          |
| `FRONTEND_IMAGE`       | Released frontend image           | Versioned GHCR image          |
| `HTTP_PORT`            | Host web port                     | `8080`                        |

See [configuration](docs/configuration.md) for the complete reference and
[`versions.yml`](versions.yml) for tested component compatibility.

## Operations and troubleshooting

- [User guide](docs/user-guide.md)
- [Developer guide](docs/developer-guide.md)
- [Architecture](docs/architecture.md)
- [Configuration](docs/configuration.md)
- [Operations, backup, restore, and upgrade](docs/operations.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Release process](docs/release-guide.md)
- [CI/CD](docs/ci-cd-guide.md)
- [Maintenance](docs/maintenance.md)
- [Contribution workflow](docs/contributing.md)
- [Git and GitHub guide](docs/github-guide.md)
- [Security policy](SECURITY.md)

## Releases and security

Versioned releases provide core packages, container images, distribution
archives, SPDX SBOMs, checksums, and image provenance. Pull requests require
code-owner review, current quality and security checks, and resolved
conversations. See the
[release page](https://github.com/YutakaX17/advanced-hello-world/releases).
