# 001C TabbarPage Items

Status: completed

## Goal

Add the current static `TabbarPage` baseline with three Cupertino tab items and
three placeholder tab pages: Explore, Chats, and Profile.

## Non-Goals

- Do not implement real Explore, Chats, or Profile feature content.
- Do not add final routing, analytics, auth, profile, chat, or avatar services.
- Do not introduce a state-management package for this local tab state.

## Business Context

- User value: the app now has the expected first tabbar shell similar to the
  SwiftUI reference.
- Product value: later feature rewrites can replace each placeholder tab content
  incrementally.
- Engineering value: the tab shell stays view-first and simple until tab
  configuration, routing, or analytics requires a stronger boundary.

## Dependencies

- Prior tasks:
  - `001A_app_page_switching_shell`
  - `001B_app_page_shell_persistence`
- Required credentials/services: none.
- Required decisions: keep real feature pages and final routing deferred.

## Affected Areas

- Modules: app shell.
- Domain concepts: static Explore, Chats, and Profile tab placeholders.
- Database: none.
- API: none.
- Functions/contracts: none.
- DTO/data: static tab config only.
- Permissions: none.
- State machines: local tab selection state.
- Integrations: none.
- Security: no sensitive data, prompts, credentials, or user chat content.
- Observability: none yet.
- Config/env: none.
- Tests: widget test for static tab items and placeholder selection.

## Write Scope

Allowed files/directories:

- `lib/core/tabbar_page/tabbar_page.dart`
- `lib/core/explore_page/explore_page.dart`
- `lib/core/chats_page/chats_page.dart`
- `lib/core/profile_page/profile_page.dart`
- `lib/core/app_page/app_page.dart`
- `lib/main.dart`
- `test/widget_test.dart`
- `ai_dev/TASKS/001C_tabbar_page_items.md`
- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/API_ROUTE_MAP.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`

Forbidden files/directories:

- Remote AI/provider code.
- Real feature pages outside the app shell.
- Final auth/session/routing implementation.

Scope expansion rule:

- Stop and update this task before editing files outside allowed scope.

## Git Workflow

- Branch Mode: simple
- Base Branch: current working branch
- Working Branch: current working branch
- Merge Target: current working branch
- Branch Required: no
- Reason: small local app-shell addition in the current simple workflow mode.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Implement `TabbarPage` with Explore, Chats, and Profile `BottomNavigationBarItem`s. | `lib/core/tabbar_page/tabbar_page.dart`. |
| S2 | completed | Render `TabbarPage` from `AppPage` instead of the red Tabbar placeholder. | `lib/core/app_page/app_page.dart`. |
| S3 | completed | Add placeholder Explore, Chats, and Profile pages with nav titles and centered page names. | page files under `lib/core/`. |
| S4 | completed | Add widget smoke coverage for the three static items. | `test/widget_test.dart`. |
| S5 | completed | Update project indexes for the new source file, routes, state, and tests. | project indexes reference task 001C. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: marks F-003 implemented for the static
  tabbar baseline.
- `ai_dev/PROJECT/FILE_MAP.md`: adds `lib/core/tabbar_page/tabbar_page.dart`,
  the three tab page files, and updates moved app-page paths.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: records TabbarPage and tab page
  implementations.
- `ai_dev/PROJECT/API_ROUTE_MAP.md`: marks Explore, Chats, and Profile tab
  placeholders as implemented.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: records the local placeholder tab
  selection state.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: adds TEST-APP-003.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: links F-003 to routes and test
  evidence.

## Verification Gates

Required:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure this stays a placeholder tab shell and does
  not introduce real feature logic prematurely.
- P0/P1 blocking criteria: app fails to compile, tab test fails, or the change
  adds provider calls/secrets/remote dependencies.

## Completion Evidence

- Files changed: `lib/core/tabbar_page/tabbar_page.dart`, three tab page files,
  `lib/core/app_page/app_page.dart`, `lib/main.dart`, `test/widget_test.dart`,
  this task file, and related AI_DEV indexes.
- Commands run: `dart format --set-exit-if-changed .`, `flutter analyze`,
  `flutter test`, `./ai_dev/bin/aidev check`, and `git diff --check`.
- Results: formatting check was stable; analyze passed with no issues; widget
  tests passed; AI_DEV check passed; diff whitespace check passed.
- Remaining risks: Explore, Chats, and Profile pages contain placeholder content
  only. Real feature content, routing, analytics, and auth/profile behavior
  remain later tasks.
