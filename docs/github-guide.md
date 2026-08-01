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

