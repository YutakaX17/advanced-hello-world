# Release guide

Use Semantic Versioning and release components in dependency order:

1. Backend core.
2. Backend assembler image.
3. Frontend core.
4. Frontend assembler image.
5. Distribution compatibility manifest and bundle.

Before tagging, require green tests, clean dependency scans, reviewed migrations,
updated documentation, and a changelog or generated release notes. Tags use
`vMAJOR.MINOR.PATCH`; package metadata uses `MAJOR.MINOR.PATCH`.

The distribution release must contain Compose configuration, `.env.example`,
documentation, `versions.yml`, checksums, and an SBOM. Record image digests in
the release notes. Never rebuild or replace an existing version tag.
