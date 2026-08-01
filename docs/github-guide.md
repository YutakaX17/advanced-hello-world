# Git and GitHub guide

## Branch and commit

```bash
git switch main
git pull --ff-only
git switch -c feat/example
git status
git add path/to/file
git diff --cached
git commit -m "feat(scope): describe the change"
git push -u origin feat/example
```

## Pull request with GitHub CLI

```bash
gh pr create --base main --fill
gh pr checks --watch
gh pr diff
gh pr review --approve
gh pr merge --squash --delete-branch
```

## Releases

```bash
git switch main
git pull --ff-only
git tag -s v0.1.0 -m "Release v0.1.0"
git push origin v0.1.0
gh release create v0.1.0 --verify-tag --generate-notes
```

Inspect automation with `gh workflow list`, `gh run list`, and
`gh run view <run-id> --log-failed`.

## Issues and milestones

Create and inspect issues from the command line:

```bash
gh issue create --title "Short outcome" --body "Acceptance criteria"
gh issue list --state open
gh issue view <number>
```

Milestones can be managed through the GitHub API:

```bash
gh api repos/OWNER/REPOSITORY/milestones
gh api --method POST repos/OWNER/REPOSITORY/milestones \
  -f title="Release 0.2" -f description="Planned outcomes"
```

Use the web interface when a visual overview is more useful: open the
repository's Issues page, select Milestones, create or open a milestone, and
assign issues from each issue's sidebar.

## Review and merge

Review the changed files, test evidence, security and migration impact,
documentation, compatibility, and rollback plan. Resolve every conversation
before approval. Repository rules permit squash merges only and delete the
source branch after merge.
