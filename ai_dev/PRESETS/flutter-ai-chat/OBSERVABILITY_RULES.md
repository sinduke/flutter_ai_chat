# Flutter AI Chat Observability Rules

## 1. Purpose

This document defines reusable observability expectations for Flutter AI chat
apps.

Observability should make development and product behavior understandable
without leaking sensitive chat content.

## 2. Event Categories

Expected event categories:

- App lifecycle.
- Screen appear/disappear.
- Navigation action.
- User action.
- Chat session action.
- Message send/generation lifecycle.
- Auth/profile/avatar changes.
- Paywall and purchase actions.
- Push and deep link handling.
- Experiment exposure.
- Error and retry events.

## 3. Sensitive Data

Never log:

- Full user chat message content by default.
- API keys or provider tokens.
- Raw auth credentials.
- Payment details.
- Private user identifiers without hashing or project-approved handling.

Development-only verbose logs may include more detail only when explicitly
allowed by project rules and never in production logs.

## 4. Local Diagnostics

Debug builds should make important failures visible to developers through:

- Console logs.
- Optional in-app developer diagnostics.
- Safe error summaries.
- Request/action trace IDs when applicable.

Infrastructure-only errors should not become user toasts unless the user can act
on them.

## 5. Event Context

Events should include safe context such as:

- Environment.
- App version/build.
- Screen or feature name.
- Action name.
- Result status.
- Error code or safe error category.
- Duration where useful.

For chat generation events, prefer IDs and counts over message content.

## 6. Provider Boundary

Concrete analytics providers must sit behind an abstraction.

Feature code should call a project analytics/logging service instead of directly
calling Firebase Analytics, Mixpanel, Sentry, Crashlytics, or another SDK.

## 7. Verification

Tasks that add major screens, actions, network calls, or AI generation flows
should verify that tracking/logging is either:

- Implemented through the approved abstraction.
- Explicitly deferred in the task file with a reason.

