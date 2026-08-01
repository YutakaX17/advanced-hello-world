# ADR 0002: REST for the initial public API

Status: Accepted

## Context

The initial capability creates and lists one simple resource.

## Decision

Use Django REST Framework and versioned `/api/v1` routes.

## Consequences

The contract is easy to test and document. GraphQL or asynchronous messaging
may be introduced later only when their additional complexity solves a concrete
requirement.
