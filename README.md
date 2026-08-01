# Advanced Hello World

The all-in-one distribution for a modular Django, React TypeScript, and
PostgreSQL learning application.

## Repository family

| Repository | Role |
| --- | --- |
| `advanced-hello-world-be-core` | Reusable Django message API package |
| `advanced-hello-world-be` | Deployable Django assembler |
| `advanced-hello-world-fe-core` | Reusable React TypeScript UI package |
| `advanced-hello-world-fe` | Deployable React assembler |
| `advanced-hello-world` | Docker Compose distribution and end-to-end tests |

## Run

Copy the environment template and start the released images:

```bash
cp .env.example .env
docker compose up -d
docker compose ps
```

Open <http://localhost:8080>. Stop the stack with:

```bash
docker compose down
```

Add `--volumes` only when you intentionally want to delete saved PostgreSQL data.

See [`docs/user-guide.md`](docs/user-guide.md) and
[`docs/developer-guide.md`](docs/developer-guide.md) for detailed guidance.

