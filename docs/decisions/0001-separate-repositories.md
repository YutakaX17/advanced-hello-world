# ADR 0001: Separate cores, assemblers, and distribution

Status: Accepted

## Context

The project is intended to teach independently versioned reusable packages,
deployable applications, and an all-in-one distribution.

## Decision

Maintain backend core, backend feature modules, backend assembler, frontend
core, frontend feature modules, frontend assembler, and distribution as
separate repositories with one-way dependencies.

## Consequences

Changes require compatibility testing and ordered releases. In return, package
boundaries are explicit and future features can be introduced without turning
the distribution into a source monorepo.
