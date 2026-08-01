# Maintenance guide

## Routine work

- Review dependency and secret-scanning alerts weekly.
- Merge supported dependency updates only after all required checks pass.
- Test backups and restoration at least once per release cycle.
- Review supported Python, Node.js, Django, React, PostgreSQL, and container
  versions quarterly.
- Keep `versions.yml`, release notes, and operational documentation aligned.

## Change ownership

Shared contracts belong to the core repositories. Domain models and API
behavior belong to backend feature modules; feature UI and API clients belong
to frontend feature modules. Runtime configuration and generated registration
belong to the assemblers. Cross-component deployment, compatibility,
operations, workspace bootstrap, and end-to-end tests belong to the
distribution.

## Triage

Create a focused issue, assign it to the appropriate milestone, document
acceptance criteria, and link the implementing pull request. Security reports
must use private vulnerability reporting rather than public issues.

```bash
gh issue create --title "Short outcome" --body "Acceptance criteria"
gh issue list --milestone "Security and quality"
gh pr create --base main --fill
```

Close a milestone only when its issues are closed and the behavior is present on
the protected default branches. Remove obsolete branches after squash merge;
retain immutable release tags and their assets.
