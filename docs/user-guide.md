# User guide

## Purpose

The page displays **Hello World** below its top bar. Enter text in the centered
form and select **Save**. A success dialog appears only after PostgreSQL has
stored the text.

## Installation

Install Docker with Docker Compose, copy `.env.example` to `.env`, replace all
placeholder secrets, and run `docker compose up -d`.

Use `docker compose ps` to inspect health and `docker compose logs backend` to
investigate API failures.

## Data

Messages remain in the named `database` volume across ordinary restarts.
Back up the database before upgrades. `docker compose down --volumes`
permanently removes local application data and should be used deliberately.
