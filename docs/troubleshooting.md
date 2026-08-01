# Troubleshooting

## Frontend is unavailable

Check `docker compose ps frontend` and its logs. Confirm `HTTP_PORT` is unused
and the frontend image can be pulled.

## API returns an error

Check backend logs and `/api/v1/health/ready`. Confirm all PostgreSQL variables
match between `db`, `migrate`, and `backend`.

## Migration service fails

Inspect `docker compose logs migrate`. Do not repeatedly edit migration history.
Restore a backup or correct configuration, then rerun the one-shot service.

## Success dialog does not appear

Use browser developer tools to inspect `POST /api/v1/messages`. A 400 indicates
validation failure; 5xx indicates API or database failure. The dialog is only
shown after HTTP 201.

## Reset local data

`docker compose down --volumes` permanently deletes the local database volume.
Use it only for disposable development environments.
