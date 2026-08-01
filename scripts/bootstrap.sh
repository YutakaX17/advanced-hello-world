#!/usr/bin/env bash
set -euo pipefail

distribution_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
workspace_root="$(dirname -- "${distribution_root}")"

clone_if_missing() {
  local repository="$1"
  local directory="$2"
  local target="${workspace_root}/${directory}"

  if [[ -d "${target}/.git" ]]; then
    printf 'Using existing %s\n' "${target}"
    return
  fi
  if [[ -e "${target}" ]]; then
    printf 'Cannot clone: %s exists but is not a Git repository\n' "${target}" >&2
    exit 1
  fi
  git clone "${repository}" "${target}"
}

clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-be-core.git" \
  "advanced-hello-world-be-core"
clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-be-messages.git" \
  "advanced-hello-world-be-messages"
clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-be.git" \
  "advanced-hello-world-be"
clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-fe-core.git" \
  "advanced-hello-world-fe-core"
clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-fe-messages.git" \
  "advanced-hello-world-fe-messages"
clone_if_missing \
  "https://github.com/YutakaX17/advanced-hello-world-fe.git" \
  "advanced-hello-world-fe"

backend_root="${workspace_root}/advanced-hello-world-be"
if [[ ! -x "${backend_root}/.venv/bin/python" ]]; then
  python3 -m venv "${backend_root}/.venv"
fi
"${backend_root}/.venv/bin/python" -m pip install --editable "${backend_root}[dev]"
(
  cd "${backend_root}"
  .venv/bin/python -m advanced_hello_world.module_installer \
    modules.json \
    --local-root "${workspace_root}"
)

frontend_root="${workspace_root}/advanced-hello-world-fe"
(
  cd "${frontend_root}"
  npm run modules:install -- --local-root "${workspace_root}"
)

printf '\nWorkspace ready at %s\n' "${workspace_root}"
printf 'Next: copy advanced-hello-world-be/.env.example to .env, configure PostgreSQL, and follow the distribution README.\n'
