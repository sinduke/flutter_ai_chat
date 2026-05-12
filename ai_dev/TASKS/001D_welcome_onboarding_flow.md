# 001D Welcome Onboarding Flow

Status: completed

## Goal

Add the placeholder Welcome and onboarding completion pages, and move AppPage
shell switching from whole-page taps to page-owned onboarding actions.

## Non-Goals

- Do not implement final auth, session restore, profile initialization, or
  analytics.
- Do not add a state-management package or final routing package.
- Do not replace the temporary `app_page.show_tab_bar` shell preference with a
  final onboarding completion store yet.

## Business Context

- User value: the onboarding entry now matches the expected flow: Welcome ->
  completed page -> tabbar shell.
- Product value: the root shell is no longer controlled by arbitrary page taps;
  feature pages can own their own actions.
- Engineering value: AppPage remains view-first and only accepts a callback from
  the onboarding flow instead of knowing onboarding UI details.

## Dependencies

- Prior tasks:
  - `001B_app_page_shell_persistence`
  - `001C_tabbar_page_items`
- Required credentials/services: none.
- Required decisions: final onboarding/auth state remains deferred.

## Affected Areas

- Modules: app shell, onboarding.
- Domain concepts: welcome, onboarding completed, page-controlled shell switch.
- Database: none.
- API: none.
- Functions/contracts: none.
- DTO/data: temporary shell preference remains `app_page.show_tab_bar`.
- Permissions: no new permission behavior.
- State machines: AppPage shell preview state and Welcome onboarding flow.
- Integrations: none.
- Security: no sensitive data, prompts, credentials, or user chat content.
- Observability: none yet.
- Config/env: none.
- Tests: widget tests for ignored page taps and Welcome -> completed -> tabbar.

## Write Scope

Allowed files/directories:

- `lib/core/app_page/app_page.dart`
- `lib/core/welcome_page/welcome_page.dart`
- `lib/core/onboarding/completed_page/onboard_completed_page.dart`
- `test/widget_test.dart`
- `ai_dev/TASKS/001D_welcome_onboarding_flow.md`
- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/API_ROUTE_MAP.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`

Forbidden files/directories:

- Remote AI/provider code.
- Real auth/session/profile implementation.
- Final routing package setup.

Scope expansion rule:

- Stop and update this task before editing files outside allowed scope.

## Git Workflow

- Branch Mode: simple
- Base Branch: current working branch
- Working Branch: current working branch
- Merge Target: current working branch
- Branch Required: no
- Reason: small local app-shell/onboarding addition in the current simple
  workflow mode.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Add WelcomePage with centered title and bottom Get Started button. | `lib/core/welcome_page/welcome_page.dart`. |
| S2 | completed | Add OnboardCompletedPage with nav title, page title, and Completed button. | `lib/core/onboarding/completed_page/onboard_completed_page.dart`. |
| S3 | completed | Remove AppPage whole-page tap switching and route shell changes through onboarding callbacks. | `lib/core/app_page/app_page.dart`. |
| S4 | completed | Update widget tests for ignored AppPage taps and Welcome -> completed -> tabbar behavior. | `test/widget_test.dart`. |
| S5 | completed | Update project indexes for onboarding routes, state, source files, and tests. | project indexes reference task 001D. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: marks F-004 implemented for the placeholder
  Welcome onboarding flow.
- `ai_dev/PROJECT/API_ROUTE_MAP.md`: marks `/welcome` implemented and adds
  `/onboarding/completed`.
- `ai_dev/PROJECT/FILE_MAP.md`: records WelcomePage, OnboardCompletedPage, and
  updated AppPage/test ownership.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: records the new onboarding pages and
  page-controlled shell switch.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: replaces whole-AppPage tap shell
  transitions with onboarding page actions.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: updates TEST-APP-001 and adds
  TEST-APP-004.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: links F-004 to the implemented
  onboarding pages and test evidence.

## Verification Gates

Required:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure AppPage no longer toggles from whole-page
  taps and onboarding actions own the shell transition.
- P0/P1 blocking criteria: app fails to compile, onboarding exit does not show
  tabbar, or the change adds provider calls/secrets/remote dependencies.

## Completion Evidence

- Files changed: `lib/core/app_page/app_page.dart`,
  `lib/core/welcome_page/welcome_page.dart`,
  `lib/core/onboarding/completed_page/onboard_completed_page.dart`,
  `test/widget_test.dart`, this task file, and related AI_DEV indexes.
- Commands run: `dart format --set-exit-if-changed .`, `flutter analyze`,
  `flutter test`, `./ai_dev/bin/aidev check`, and `git diff --check`.
- Results: formatting check was stable; analyze passed with no issues; widget
  tests passed after the completion page Completed action was updated to pop the
  route after notifying AppPage; AI_DEV check passed; diff whitespace check
  passed.
- Remaining risks: the flow still uses temporary shell preference
  `app_page.show_tab_bar`; final onboarding completion/auth/session persistence
  remains later work.
