# 001F Tabbar Depth And Button Component

Status: completed

## Goal

Hide the tabbar whenever the active tab is showing a non-root page, animate it
back when returning to first-level tab pages, rename the onboarding completion
action to `Completed`, and consolidate red full-width action buttons into a
shared component with white text.

## Non-Goals

- Do not introduce a final routing package.
- Do not implement real auth/session logout behavior.
- Do not redesign the first-level tab pages.

## Affected Areas

- Modules: app shell, onboarding, settings, common widgets.
- State machines: tab route-depth visibility.
- Tests: widget coverage for tabbar hiding and primary button text contrast.

## Write Scope

Allowed files/directories:

- `lib/core/tabbar_page/tabbar_page.dart`
- `lib/core/welcome_page/welcome_page.dart`
- `lib/core/onboarding/completed_page/onboard_completed_page.dart`
- `lib/core/settings_page/settings_page.dart`
- `lib/common/widgets/app_primary_action_button.dart`
- `test/widget_test.dart`
- `ai_dev/TASKS/001F_tabbar_depth_and_button_component.md`
- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Replace fixed CupertinoTabScaffold usage with a custom Cupertino tab shell that preserves per-tab CupertinoTabView navigators. | `lib/core/tabbar_page/tabbar_page.dart`. |
| S2 | completed | Track active tab route depth and slide/fade the tabbar out for depth greater than one. | `lib/core/tabbar_page/tabbar_page.dart`. |
| S3 | completed | Add AppPrimaryActionButton and migrate Welcome, OnboardCompleted, and Settings actions to it. | `lib/common/widgets/app_primary_action_button.dart`. |
| S4 | completed | Rename onboarding completion button text from Exit to Completed. | `lib/core/onboarding/completed_page/onboard_completed_page.dart`. |
| S5 | completed | Update tests and project indexes. | `test/widget_test.dart`, project indexes. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: links F-003, F-004, and F-008 to this
  task.
- `ai_dev/PROJECT/FILE_MAP.md`: records AppPrimaryActionButton and updates
  TabbarPage, onboarding, settings, and test ownership.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: records the custom tab shell,
  shared primary action button, and Completed onboarding action.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: records route-depth tabbar
  hide/show states.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: records coverage for tabbar
  hiding and readable primary button text.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: links route-depth tabbar visibility
  and the shared primary action button to the relevant features.

## Verification Gates

Required:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure each tab keeps its own navigation stack,
  tabbar visibility follows active tab route depth, and red action buttons
  always render readable white text.
- P0/P1 blocking criteria: app fails to compile, tab selection breaks, Settings
  does not hide the tabbar, onboarding completion action text regresses, or the
  shared button introduces unreadable contrast.

## Completion Evidence

- Files changed: `lib/core/tabbar_page/tabbar_page.dart`,
  `lib/core/welcome_page/welcome_page.dart`,
  `lib/core/onboarding/completed_page/onboard_completed_page.dart`,
  `lib/core/settings_page/settings_page.dart`,
  `lib/common/widgets/app_primary_action_button.dart`, `test/widget_test.dart`,
  this task file, and related AI_DEV indexes.
- Results: widget tests cover Settings route-depth tabbar hiding, Completed
  action text, and white primary button text on the red background. `flutter
  analyze`, `flutter test`, and `git diff --check` passed; `aidev check` passed
  after this task file was expanded with required sections.
- Remaining risks: this is still a view-first tab shell; final routing and
  shared navigation policies remain later work.
