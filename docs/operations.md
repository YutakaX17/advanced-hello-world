# Operations

## Health and logs

Use `docker compose ps` for service health and `docker compose logs --since 15m
backend` for API diagnostics. The endpoints are `/api/v1/health/live` and
`/api/v1/health/ready`.

## Backup

Create an application-consistent logical backup:

```bash
docker compose exec -T db pg_dump \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  --format=custom > advanced-hello-world.dump
```

Protect the dump as sensitive data and test restoration regularly.

## Restore

Stop application writers, recreate an empty target database, and restore:

```bash
docker compose stop backend
docker compose exec -T db pg_restore \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  --clean --if-exists < advanced-hello-world.dump
docker compose run --rm migrate
docker compose start backend
```

Verify readiness and save a test message before reopening traffic.

## Upgrade

1. Back up PostgreSQL.
2. Review release notes and `versions.yml`.
3. Update image tags or digests.
4. Pull images with `docker compose pull`.
5. Run `docker compose up -d --wait`; the migration service runs first.
6. Run the Playwright smoke journey.

Rollback application images to the prior digests. Database rollback is not
automatic; restore the backup when a migration is not backward compatible.
