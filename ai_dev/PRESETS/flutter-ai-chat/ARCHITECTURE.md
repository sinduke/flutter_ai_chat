# Flutter AI Chat Architecture Rules

## 1. Purpose

This document defines the reusable architecture baseline for Flutter AI chat
apps.

The goal is practical production structure: feature code should be easy to
change, mock, test, and later connect to real services without forcing a large
rewrite.

## 2. Architecture Style

Default style:

- Feature-first source layout.
- Presentation, application, domain, and data boundaries where useful.
- Mock-first service protocols.
- Explicit dependency injection.
- Router-owned navigation.
- Design system before repeated UI.

Do not introduce heavyweight architecture before the task needs it. Early
screens may be simple, but they must leave room for later ViewModel,
Interactor, Repository, or Router evolution.

## 3. Source Layout

Default Flutter source layout:

```text
lib/
  app/
    app.dart
    app_bootstrap.dart
    app_router.dart
    app_dependencies.dart
  common/
    design/
    widgets/
    routing/
    utils/
  features/
    <feature>/
      presentation/
        pages/
        widgets/
        controllers/
      application/
        use_cases/
        services/
      domain/
        models/
        repositories/
        policies/
      data/
        models/
        services/
        repositories/
        mock/
  main.dart
```

Small features may start with fewer folders. Add layers when they remove real
coupling or support the current task's testability.

## 4. Dependency Direction

Allowed direction:

```text
presentation -> application -> domain
data -> domain protocols
app composition -> presentation/application/data wiring
```

Forbidden direction:

```text
domain -> Flutter widgets
domain -> BuildContext
domain -> package-specific HTTP/cache SDKs
application -> concrete remote service when a protocol exists
presentation -> raw provider SDKs
widgets -> persistence or network clients directly
```

UI widgets should render state and emit intent. They should not own API calls,
storage details, or provider-specific AI behavior.

## 5. Feature Boundaries

Typical AI chat features:

- `app_shell`
- `onboarding`
- `auth`
- `profile`
- `avatar`
- `explore`
- `chats`
- `chat`
- `settings`
- `paywall`
- `dev_settings`
- `analytics`
- `experiments`
- `push`
- `deep_linking`

Shared widgets belong in `common/widgets` only when they are genuinely reusable.
Feature-specific components stay inside the owning feature.

## 6. App Shell

The app shell owns:

- MaterialApp or CupertinoApp configuration.
- Theme and localization configuration.
- Router configuration.
- Global providers/dependencies.
- Top-level lifecycle observers.

Feature pages must not reconfigure global app dependencies.

## 7. Routing

Routing rules:

- Centralize route names and typed route data where practical.
- Keep route construction separate from feature widgets.
- Navigation callbacks may be simple early on, but should converge toward a
  router/delegate layer when navigation becomes cross-feature.
- Do not pass unrelated service objects through route arguments.

For source-history rewrites, preserve the product navigation behavior first,
then evolve the Flutter routing abstraction when the source app history reaches
that architecture stage.

## 8. Dependency Injection

Dependencies should be assembled in one app-level composition area.

Prefer:

- Protocol/interface first for services that will have mock and remote versions.
- Mock services for early UI and tests.
- Explicit constructor injection for view models/controllers/use cases.
- Provider container or dependency scope only at stable composition boundaries.

Avoid:

- Global mutable singletons for business services.
- Direct SDK construction inside pages/widgets.
- Passing a large container into every feature object when a narrower
  dependency is enough.

## 9. Design System

Create or reuse a design system before repeating UI primitives.

Minimum expected foundations:

- Colors.
- Typography.
- Spacing.
- Radii.
- Theme.
- Buttons.
- Text fields.
- Avatars/images.
- Loading and empty states.

Design tokens should be framework-native Dart constants or theme extensions.
Feature UI should use them instead of scattering ad hoc values.

## 10. Environment Modes

AI chat apps usually need at least:

- `mock`: local deterministic data, no external network requirement.
- `dev`: local or development backend/provider settings.
- `prod`: production-safe defaults.

Environment selection must not leak secrets into source code. Runtime keys,
provider credentials, and sensitive endpoints belong in secure environment
configuration.

## 11. Platform Policy

Flutter code should remain platform-neutral unless the feature requires native
behavior.

When native integration is needed:

- Keep platform channel code isolated.
- Document platform-specific behavior in project indexes.
- Add fallback behavior for unsupported platforms when practical.

