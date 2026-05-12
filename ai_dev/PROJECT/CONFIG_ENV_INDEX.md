# Config and Environment Index

## 1. Purpose

This file tracks environment modes, runtime config, and sensitive setting rules
for the Flutter AI Chat project.

Do not commit provider secrets, AI API keys, purchase secrets, or private user
data.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deprecated`

## 3. Environment Modes

| Mode | Purpose | Network | Credentials | Status |
| --- | --- | --- | --- | --- |
| `mock` | deterministic local UI and tests | no remote dependency | none | planned |
| `dev` | local/dev provider integration | allowed when configured | secure local env only | planned |
| `prod` | production release | production providers | secure platform config only | planned |

## 4. Planned Config Keys

| Key | Purpose | Type | Environment | Default | Sensitive | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `APP_ENV` | app environment mode | enum | all | `mock` | no | app bootstrap | planned |
| `AI_PROVIDER` | selected AI provider | string | dev/prod | `mock` | no | AI service composition | planned |
| `AI_API_BASE_URL` | backend/provider proxy URL | string | dev/prod | none | no unless private | AI service composition | planned |
| `ANALYTICS_ENABLED` | analytics switch | bool | all | false in mock | no | analytics facade | planned |
| `PURCHASES_ENABLED` | purchase/paywall switch | bool | all | false | no | entitlement service | planned |
| `DEV_SETTINGS_ENABLED` | developer tools availability | bool | mock/dev | true for debug | no | dev settings | planned |

## 5. Local Preference Keys

| Key | Purpose | Type | Default | Sensitive | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- |
| `app_page.show_tab_bar` | temporary AppPage shell preview visibility, similar to SwiftUI AppStorage for the current placeholder shell; reset to false by the placeholder Settings logout flow | bool | false | no | 001B_app_page_shell_persistence, 001E_profile_settings_logout | implemented |

## 6. Secret Policy

- AI provider keys must not be committed to Flutter source.
- Prefer backend proxy or secure platform configuration for production secrets.
- Local `.env` files must remain ignored.
- Logs must not print provider secrets, raw prompts, raw chat content, or auth
  credentials by default.

## 7. Update Rules

Update this file when:

- A new environment mode is added.
- A dependency requires configuration.
- A platform-specific config file becomes part of the build.
- A secret handling decision changes.
