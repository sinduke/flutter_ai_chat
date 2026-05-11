# 001A AppPage Switching Shell

Status: completed

## Goal

Implement the current `AppPage` as a view-first Flutter root page that mirrors
the requested SwiftUI behavior: signed-out onboarding placeholder, signed-in
tabbar placeholder, tap-to-toggle local state, trailing slide transition,
official widget previews, and a Cupertino-first widget surface.

## Non-Goals

- Do not add real auth, persistence, routing, DI, services, or remote providers.
- Do not implement the final tab navigation content yet.
- Do not introduce a state-management package for this local placeholder state.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Implement `AppPage` with local `_showTabBar` state and `AnimatedSwitcher` slide transition. | `lib/core/app_page.dart` contains `AppPage`. |
| S2 | completed | Replace the Flutter counter home screen with `AppPage` using `CupertinoApp`. | `lib/main.dart` uses `home: AppPage()`. |
| S3 | completed | Add official `@Preview(...)` entries for `AppPage` and the placeholder components. | `lib/core/app_page.dart` imports `package:flutter/widget_previews.dart`. |
| S4 | completed | Update the widget smoke test for the onboarding-to-tabbar toggle. | `test/widget_test.dart` verifies the tap transition. |
| S5 | completed | Update source and verification indexes for this app-shell change. | Project indexes reference the changed source and test files. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: F-001 moved to implemented app shell.
- `ai_dev/PROJECT/FILE_MAP.md`: added `lib/core/app_page.dart` and updated entrypoint/test records.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: added AppPage and widget test coverage.
- `ai_dev/PROJECT/API_ROUTE_MAP.md`: root route now maps to `AppPage`.
- `ai_dev/PROJECT/PROJECT_RULES.md`: records Cupertino-first UI and per-page/component preview rules.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: documented the temporary AppPage shell preview state.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: added `TEST-APP-001`.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: linked app foundation to AppPage and the widget test.

## Verification Gates

Required:

- `flutter pub get`
- `dart format --set-exit-if-changed lib/main.dart lib/core/app_page.dart test/widget_test.dart`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure this remains view-first and does not imply final auth or tab routing.
- P0/P1 blocking criteria: app fails to boot, widget test fails, or code introduces provider credentials/remote calls.

## Completion Evidence

- Files changed: `lib/core/app_page.dart`, `lib/main.dart`, `lib/common/design/app_colors.dart`, `lib/common/design/app_typography.dart`, `test/widget_test.dart`, `lib/common/design/app_theme.dart` format-only, and related AI_DEV indexes.
- Commands run: `flutter pub get`, `dart format --set-exit-if-changed lib/main.dart lib/core/app_page.dart test/widget_test.dart`, `dart format --set-exit-if-changed .`, `flutter analyze`, `flutter test`, `./ai_dev/bin/aidev check`, `git diff --check`.
- Results: final formatting check was stable; analyze, widget test, AI_DEV check, and diff check passed.
- Remaining risks: `Tabbar` and `Onboarding` are placeholders only. Real auth state, routing, and tab content remain later tasks.
