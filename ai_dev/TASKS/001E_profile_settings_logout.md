# 001E Profile Settings Logout

Status: completed

## Goal

Add a top-right Settings navigation item to Profile, add the placeholder
Settings page, hide the tabbar while Settings is on top of the Profile tab, and
let Settings logout return the AppPage shell to onboarding after a one-second
delay.

## Non-Goals

- Do not implement real auth/session invalidation, token clearing, or remote
  logout.
- Do not add final routing, analytics, profile services, or user data models.
- Do not replace the temporary `app_page.show_tab_bar` shell preference.

## Business Context

- User value: Profile now exposes a Settings entry point and a visible Logout
  action.
- Product value: logout can return the app to onboarding without relying on the
  removed whole-page AppPage tap switch, and second-level settings navigation no
  longer leaves the first-level tabbar visible.
- Engineering value: AppPage remains the only owner of the temporary shell
  preference; Settings only notifies through callbacks.

## Dependencies

- Prior tasks:
  - `001B_app_page_shell_persistence`
  - `001C_tabbar_page_items`
  - `001D_welcome_onboarding_flow`
- Required credentials/services: none.
- Required decisions: real auth/session logout remains deferred.

## Affected Areas

- Modules: app shell, profile, settings.
- Domain concepts: profile settings entry, placeholder logout, onboarding
  return.
- Database: none.
- API: none.
- Functions/contracts: none.
- DTO/data: temporary shell preference remains `app_page.show_tab_bar`.
- Permissions: no new permission behavior.
- State machines: AppPage shell preview state, tab route-depth visibility, and
  profile settings logout flow.
- Integrations: none.
- Security: no sensitive data, credentials, or user chat content.
- Observability: none yet.
- Config/env: local preference key reset through AppPage.
- Tests: widget test for Profile -> Settings tabbar hiding -> delayed Logout ->
  onboarding.

## Write Scope

Allowed files/directories:

- `lib/core/app_page/app_page.dart`
- `lib/core/tabbar_page/tabbar_page.dart`
- `lib/core/profile_page/profile_page.dart`
- `lib/core/settings_page/settings_page.dart`
- `lib/common/widgets/app_primary_action_button.dart`
- `test/widget_test.dart`
- `ai_dev/TASKS/001E_profile_settings_logout.md`
- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/API_ROUTE_MAP.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`

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
- Reason: small local profile/settings shell addition in the current simple
  workflow mode.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | completed | Add SettingsPage with nav title, centered page name, and Logout button. | `lib/core/settings_page/settings_page.dart`. |
| S2 | completed | Add Profile top-right Settings nav item that pushes SettingsPage. | `lib/core/profile_page/profile_page.dart`. |
| S3 | completed | Pass the temporary logout callback from AppPage through TabbarPage/ProfilePage to SettingsPage. | `lib/core/app_page/app_page.dart`, `lib/core/tabbar_page/tabbar_page.dart`. |
| S4 | completed | Add widget coverage for Settings hiding the tabbar and delayed logout returning AppPage to onboarding. | `test/widget_test.dart`. |
| S5 | completed | Update project indexes for settings route, state, source files, tests, and shell preference behavior. | project indexes reference task 001E. |

## Index Updates

- `ai_dev/PROJECT/FEATURE_MAP.md`: marks F-008 implemented for the
  profile/settings logout baseline.
- `ai_dev/PROJECT/API_ROUTE_MAP.md`: marks `/settings` implemented.
- `ai_dev/PROJECT/FILE_MAP.md`: records SettingsPage and updated AppPage,
  TabbarPage, ProfilePage, and test ownership.
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`: records SettingsPage and logout
  callback handoff.
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`: adds Settings logout transition back
  to onboarding and route-depth tabbar hiding.
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`: adds TEST-APP-005.
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`: links F-008 to settings route and
  widget evidence.
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`: notes logout resets the temporary shell
  preference.

## Verification Gates

Required:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `./ai_dev/bin/aidev check`
- `git diff --check`

## Review Plan

- Review mode: self-review plus automated checks.
- Required reviewer focus: ensure Settings does not own AppPage persistence,
  the logout delay cannot be triggered repeatedly, and tabbar visibility follows
  active tab route depth.
- P0/P1 blocking criteria: app fails to compile, Profile cannot open Settings,
  logout does not return to onboarding, or the change adds real auth/provider
  dependencies.

## Completion Evidence

- Files changed: `lib/core/app_page/app_page.dart`,
  `lib/core/tabbar_page/tabbar_page.dart`,
  `lib/core/profile_page/profile_page.dart`,
  `lib/core/settings_page/settings_page.dart`, `test/widget_test.dart`, this
  task file, and related AI_DEV indexes.
- Commands run: `dart format --set-exit-if-changed .`, `flutter analyze`,
  `flutter test`, `./ai_dev/bin/aidev check`, and `git diff --check`.
- Results: formatting check passed after formatting the new files; analyze
  passed with no issues; widget tests passed including the Settings logout
  return-to-onboarding path; AI_DEV check passed; diff whitespace check passed.
- Remaining risks: the logout flow only resets the temporary shell preference;
  real auth/session invalidation, account state clearing, analytics, and user
  profile cleanup remain later work.
