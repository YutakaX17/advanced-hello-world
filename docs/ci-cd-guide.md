# CI/CD guide

Every pull request runs repository-specific formatting, linting, type checking,
tests, builds, dependency review, CodeQL analysis, and a high/critical
filesystem vulnerability scan. Workflow actions are pinned to full commit
identifiers. Branch protection requires the applicable quality and security
jobs, an approving review, and resolved conversations.

Assembler tags build versioned OCI images in GitHub Container Registry with
provenance and SBOM attestations. Core tags publish package archives plus an SPDX
SBOM and SHA-256 checksums. Distribution tags publish the Compose bundle,
compatibility manifest, documentation, SPDX SBOM, and checksums.

Release in dependency order and never move an existing tag. Inspect a pull
request and its automation with:

```bash
gh pr checks --watch
gh run list --limit 20
gh run view <run-id> --log-failed
gh release view v0.1.0
```

Dependabot checks package, container, and workflow dependencies weekly. Review
its changes like any other pull request; do not merge when integration or
security checks fail.

GitHub-hosted secrets are limited to the default token wherever possible.
Workflow permissions are declared explicitly and use the minimum access needed
by each job.
