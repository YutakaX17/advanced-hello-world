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

The backend and frontend each use a reusable core, independently versioned
feature modules, and a deployable assembler. Cores contain public contracts and
must never import features or assemblers. Assemblers select exact versions,
install modules, provide runtime configuration, and produce images.

| Repository         | Owns                                                         | Must not own                      |
| ------------------ | ------------------------------------------------------------ | --------------------------------- |
| Backend core       | Module contract, health endpoints, historical migrations     | Feature behavior or containers    |
| Backend messages   | Message model, state adoption, serializers, and API views     | Project settings or deployment    |
| Backend assembler  | Manifest installer, Django registration, Gunicorn, image      | Feature implementation            |
| Frontend core      | Shell, layout, typed module and factory contracts             | Feature pages or Nginx             |
| Frontend messages  | Message page, API client, styles, and notification behavior   | Browser entry point or deployment |
| Frontend assembler | Manifest installer, generated routes, Vite, Nginx, image      | Database behavior                 |
| Distribution       | Bootstrap, Compose, compatibility, E2E tests, operator docs   | Feature implementation            |

## Dependency rules

Feature modules depend on core contracts; assemblers select core and feature
versions; the distribution selects assembler images. Backend and frontend
`modules.json` files are authoritative within their stacks, while
`versions.yml` records the tested cross-stack combination.

## API contract

`POST /api/v1/messages` accepts a JSON `text` value, trims whitespace, rejects
blank or overlong values, persists a UUID-keyed message, and returns HTTP 201.
Liveness does not query dependencies; readiness verifies database access.
