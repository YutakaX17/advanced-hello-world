# Security policy

Do not disclose suspected vulnerabilities in public issues. Use GitHub private
vulnerability reporting when enabled on the repository. Maintainers will
acknowledge a report, assess affected supported versions, coordinate a fix, and
publish an advisory when appropriate.

Never commit credentials or real `.env` files. Rotate a secret immediately if
it is exposed.

GitHub secret scanning and push protection are enabled as preventive controls.
Treat an alert as an incident: revoke or rotate the credential first, remove it
from repository history when required, document the response privately, and
close the alert only after verifying the credential can no longer be used.

Supported releases receive security fixes on the latest minor release. Older
demonstration releases are provided as-is.
