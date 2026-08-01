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

## Native Django reports PostgreSQL password authentication failure

Backend `manage.py` commands automatically load
`advanced-hello-world-be/.env`; `.env.example` is never loaded as runtime
configuration. Shell-exported variables take precedence. Confirm the resolved
host, port, database, and user without printing the password, then verify that
the PostgreSQL role actually has the same password.

Changing `.env` does not change an existing PostgreSQL role or an existing
Docker volume. Update the role password deliberately with PostgreSQL
administration tools. Do not delete a database volume merely to make
credentials match when it contains data that must be retained.

If authentication succeeds but the host does not answer on port 5432, address
service reachability, listen addresses, firewall rules, or the selected host;
that is a separate problem from environment-file loading.

## Success dialog does not appear

Use browser developer tools to inspect `POST /api/v1/messages`. A 400 indicates
validation failure; 5xx indicates API or database failure. The dialog is only
shown after HTTP 201.

## Reset local data

`docker compose down --volumes` permanently deletes the local database volume.
Use it only for disposable development environments.
