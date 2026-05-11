# Permission and Entitlement Index

## 1. Purpose

This file tracks user access, authentication, paywall entitlements, and
capability gates for the Flutter AI Chat project.

The early app may be mock-only, but entitlement boundaries should be explicit
before paywall or purchases are implemented.

## 2. Actor Types

| Actor | Description |
| --- | --- |
| `anonymous_user` | User before sign-in or account creation. |
| `signed_in_user` | User with local/remote identity. |
| `subscriber` | User with active chat entitlement. |
| `developer` | Local development actor using mock/dev settings. |

## 3. Planned Capabilities

| Capability ID | Capability | Actors | Gate | Feature | Status |
| --- | --- | --- | --- | --- | --- |
| CAP-APP-001 | open app shell | anonymous_user, signed_in_user | none | F-001 | planned |
| CAP-ONBOARDING-001 | complete onboarding | anonymous_user, signed_in_user | none | F-004 | planned |
| CAP-EXPLORE-001 | browse avatars | anonymous_user, signed_in_user | none initially | F-005 | planned |
| CAP-CHAT-001 | open chat session | anonymous_user, signed_in_user | entitlement later | F-007 | planned |
| CAP-CHAT-002 | send message | anonymous_user, signed_in_user, subscriber | entitlement/rate limit later | F-007 | planned |
| CAP-PAYWALL-001 | purchase/restore entitlement | anonymous_user, signed_in_user | purchase provider later | F-010 | planned |
| CAP-DEV-001 | open developer settings | developer | debug/dev only | dev_settings | planned |

## 4. Rules

- Do not put purchase provider logic inside chat widgets.
- UI may check a capability but must not own entitlement persistence.
- Developer-only controls must not be exposed in production builds unless an
  explicit project decision allows it.
- When auth or purchase work starts, update this file with real gates and
  negative tests.
