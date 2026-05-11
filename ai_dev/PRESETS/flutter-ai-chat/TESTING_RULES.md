# Flutter AI Chat Testing Rules

## 1. Purpose

This document defines reusable test expectations for Flutter AI chat apps.

Tests should protect UI behavior, state transitions, service contracts,
navigation, and AI-chat-specific edge cases.

## 2. Test Levels

Use the smallest useful test level.

Expected categories as the project grows:

- Pure Dart unit tests.
- View model/controller tests.
- Service/repository tests with fakes.
- Widget tests.
- Golden tests for stable UI where useful.
- Integration tests for critical end-to-end flows.
- Platform integration tests only when native behavior is touched.

## 3. Unit Tests

Unit tests should cover:

- Domain model parsing and equality.
- Chat message ordering and grouping.
- Entitlement decisions.
- Experiment variant mapping.
- Error mapping.
- Use case behavior with fake services.

Unit tests must not require real network, real credentials, or production
provider SDKs.

## 4. View Model / Controller Tests

Controller tests should cover:

- Initial state.
- Loading success.
- Loading empty.
- Loading failure.
- User action transitions.
- Message send success/failure.
- AI reply generation success/failure.
- Retry/cancel behavior when supported.

## 5. Widget Tests

Widget tests should cover:

- App shell starts.
- Important pages render.
- Empty/loading/error/data states.
- Chat composer behavior.
- Message bubble rendering.
- Navigation callbacks.
- Dark/light theme safety when custom colors are used.

Widget tests should use mock services and must not call remote providers.

## 6. Integration Tests

Integration tests are useful for:

- First app launch.
- Onboarding completion.
- Tab navigation.
- Starting a chat.
- Sending a message with a mock AI service.
- Opening settings/profile.
- Paywall gating when present.

Keep integration tests deterministic.

## 7. Verification Commands

Before source work exists:

- Documentation consistency check.
- `git diff --check`.
- `git status --short`.

For normal Flutter source changes:

- `flutter pub get` when dependencies change.
- `dart format --set-exit-if-changed .` or project-approved formatting command.
- `flutter analyze`.
- `flutter test`.

For platform or asset changes:

- Run the relevant platform build when practical.
- Verify generated assets are committed or intentionally ignored.

## 8. Review Checklist

Before completing a task, confirm:

- The task file lists verification gates.
- Tests match risk and changed behavior.
- Mock services exist for new remote/provider behavior.
- Feature indexes were updated when contracts changed.
- UI states are represented for loading, empty, error, and success.
- Sensitive data is not logged.

