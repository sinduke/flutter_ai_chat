# 001B AppPage Shell Persistence

Status: completed

## Goal

Persist the current temporary `AppPage` onboarding/tabbar preview state so the
app can restore the last selected shell after restart, similar to SwiftUI
`AppStorage`.

## Non-Goals

- Do not add final auth, session, onboarding completion, routing, or tab
  content.
- Do not introduce a global state-management package or dependency injection
  framework.
- Do not treat `showTabBar` as the final business source of truth. This is a
  temporary app-shell preference until real auth/onboarding state exists.

## Business Context

- User value: the current root shell can remember the last visible placeholder
  surface across app restarts, matching the requested SwiftUI `AppStorage`
  behavior.
- Product value: the first-phase app shell stays runnable while preserving a
  clear path to replace this temporary state with real onboarding/auth state.
- Engineering value: persistence is introduced through a narrow local adapter,
  without committing the project to final state management or routing packages.

## Architecture Notes

- Current architecture stage: `view-first`.
- Smallest next step: add a narrow `AppPageShellStorage` persistence adapter for
  this one shell preference.
- Reason: `AppPage` now needs durable local state, but the project still has no
  evidence requiring app-wide state management, Router, Repository, or DI.
- Tradeoff: the persisted key is a temporary shell flag and must later be
  replaced or migrated when real auth/session/onboarding state is introduced.

## Dependencies

- Package: `shared_preferences` for simple cross-platform key-value
  persistence.
- Prior task: `001A_app_page_switching_shell`.
- Required credentials/services: none.
- Required decisions: keep final auth/session/onboarding source of truth
  deferred.

## Affected Areas

- Modules: app shell.
- Domain concepts: temporary onboarding/tabbar preview state.
- Database: none.
- API: none.
- Functions/contracts: `AppPageShellStorage.loadShowTabBar` and
  `saveShowTabBar`.
- DTO/data: local preference key `app_page.show_tab_bar`.
- Permissions: none.
- State machines: AppPage shell preview state.
- Integrations: platform SharedPreferences through Flutter plugin.
- Security: no sensitive data, prompts, credentials, or user chat content.
- Observability: verification output only.
- Config/env: local preference key documentation.
- Tests: widget tests for write and restore behavior.

## Write Scope

Allowed files/directories:

- `lib/main.dart`
- `lib/core/app_page/app_page.dart`
- `lib/core/app_page/app_page_shell_storage.dart`
- `test/widget_test.dart`
- `pubspec.yaml`
- `pubspec.lock`
- `macos/Flutter/GeneratedPluginRegistrant.swift`
- `ai_dev/TASKS/001B_app_page_shell_persistence.md`
- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/FUNCTION_SIGNATURE_INDEX.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`
- `ai_dev/PROJECT/DECISION_LOG.md`
- `ai_dev/PROJECT/RISK_REGISTER.md`

Forbidden files/directories:

- Feature modules unrelated to the app shell.
- Remote AI/provider code.
- Final auth/session/routing implementation.

Scope expansion rule:

- Stop and update this task before editing files outside allowed scope.

## Git Workflow

- Branch Mode: simple
- Base Branch: current working branch
- Working Branch: current working branch
- Merge Target: current working branch
- Branch Required: no
- Reason: current project workflow allows simple mode for small local solo
  changes, while still requiring task/index updates and verification.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Add `shared_preferences` dependency for simple key-value app preference storage. | `pubspec.yaml` and platform registrant update. |
| S2 | completed | Add `AppPageShellStorage` with a `SharedPreferencesAsync` implementation. | `lib/core/app_page/app_page_shell_storage.dart`. |
| S3 | completed | Restore and save `AppPage` shell state through the storage boundary. | `lib/core/app_page/app_page.dart`. |
| S4 | completed | Update widget tests for persisted restore behavior. | `test/widget_test.dart`. |
| S5 | completed | Update ai_dev maps for state, dependency, function, and verification evidence. | project indexes reference task 001B. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: F-001 now records persisted temporary shell
  state and the 001B task.
- `ai_dev/PROJECT/FILE_MAP.md`: adds
  `lib/core/app_page/app_page_shell_storage.dart` and updates AppPage, main, and
  widget test records.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: records the shell persistence adapter
  and updated test coverage.
- `ai_dev/PROJECT/FUNCTION_SIGNATURE_INDEX.md`: adds `FN-APP-002` and
  `FN-APP-003`.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: records restore/persist side effects
  for the temporary AppPage shell state.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: adds persisted restore coverage.
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`: documents local preference key
  `app_page.show_tab_bar`.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: links F-001 to the local preference
  key, functions, and tests.
- `ai_dev/PROJECT/DECISION_LOG.md`: records the `shared_preferences` decision.
- `ai_dev/PROJECT/RISK_REGISTER.md`: records the risk of confusing temporary
  shell preference with final auth state.

## Verification Gates

Required:

- `flutter pub get`
- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure persistence stays scoped to the temporary app
  shell and does not imply final auth/session behavior.
- P0/P1 blocking criteria: app fails to boot, test restore path fails, or the
  change introduces provider secrets, remote SDK calls, or a global state
  package.

## Completion Evidence

- Files changed: `lib/core/app_page/app_page.dart`,
  `lib/core/app_page/app_page_shell_storage.dart`, `lib/main.dart`,
  `test/widget_test.dart`, `pubspec.yaml`, `pubspec.lock`,
  `macos/Flutter/GeneratedPluginRegistrant.swift`, this task file, and related
  AI_DEV indexes.
- Commands run: `flutter pub add shared_preferences:^2.5.5`,
  `flutter pub get`, `dart format --set-exit-if-changed .`,
  `flutter analyze`, `flutter test`, `./ai_dev/bin/aidev check`, and
  `git diff --check`.
- Results: dependency resolution completed; formatting was stable; analyze
  found no issues; both widget tests passed; AI_DEV check passed; diff
  whitespace check passed.
- Remaining risks: `app_page.show_tab_bar` is temporary shell state only. Real
  auth/session/onboarding routing must replace or migrate it later.
