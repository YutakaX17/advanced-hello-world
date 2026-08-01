# Configuration reference

| Variable               | Required | Purpose                                   |
| ---------------------- | -------- | ----------------------------------------- |
| `POSTGRES_DB`          | Yes      | PostgreSQL database name                  |
| `POSTGRES_USER`        | Yes      | Non-superuser application account         |
| `POSTGRES_PASSWORD`    | Yes      | Database password                         |
| `DJANGO_SECRET_KEY`    | Yes      | Django cryptographic signing secret       |
| `DJANGO_ALLOWED_HOSTS` | Yes      | Comma-separated accepted host names       |
| `CORS_ALLOWED_ORIGINS` | Yes      | Comma-separated browser origins           |
| `BACKEND_IMAGE`        | Yes      | Versioned or digest-pinned backend image  |
| `FRONTEND_IMAGE`       | Yes      | Versioned or digest-pinned frontend image |
| `HTTP_PORT`            | No       | Host HTTP port; defaults to 8080          |

Production secrets must be supplied by the deployment platform and must not be
committed. Treat `.env.example` only as a schema. Restrict the database network
to application services and do not publish port 5432.
