# Architecture

## System context

Advanced Hello World is a browser application with three runtime components:
an unprivileged Nginx frontend, a Gunicorn-hosted Django API, and PostgreSQL.
The distribution runs database migrations as a one-shot service before starting
the API.

```text
Browser -> Nginx frontend -> Django REST API -> PostgreSQL
                              ^
                              |
                         migration job
```

## Repository boundaries

The backend and frontend each use a reusable core plus a deployable assembler.
The cores contain public application contracts and must never import from their
assemblers. Assemblers select versions, provide runtime configuration, and
produce images. The distribution consumes published images and owns cross-stack
tests.

| Repository         | Owns                                                      | Must not own                      |
| ------------------ | --------------------------------------------------------- | --------------------------------- |
| Backend core       | Message model, migrations, serializers, API views         | Deployment settings or containers |
| Backend assembler  | Django settings, root URLs, Gunicorn, backend image       | Reusable UI or Compose            |
| Frontend core      | Shell, form, API client, notification behavior            | Nginx or deployment configuration |
| Frontend assembler | Browser entry point, Vite, Nginx, frontend image          | Database behavior                 |
| Distribution       | Compose, compatibility versions, E2E tests, operator docs | Feature implementation            |

## Dependency rules

Dependencies point from core to assembler to distribution. Release builds use
tagged core packages and versioned images. `versions.yml` is the compatibility
record for a distribution release. Development overrides may follow `main`, but
release Compose files must not.

## API contract

`POST /api/v1/messages` accepts a JSON `text` value, trims whitespace, rejects
blank or overlong values, persists a UUID-keyed message, and returns HTTP 201.
Liveness does not query dependencies; readiness verifies database access.
