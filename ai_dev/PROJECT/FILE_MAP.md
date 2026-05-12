# File Map

## 1. Purpose

This file is the path-level source file map for the current Flutter AI Chat
project.

`IMPLEMENTATION_MAP.md` explains architecture placement and implemented source
coverage. `FILE_MAP.md` is the mechanical inventory future AI agents should
update whenever files are created, moved, or deleted.

## 2. Current Status

Status: Flutter view-first root page plus design-token foundation and a narrow
AppPage shell preference adapter exist.

The app currently has a Flutter entrypoint, `AppPage` root shell placeholder,
temporary persisted shell preference, a static three-item tabbar page, a
view-first profile/settings logout flow, widget smoke coverage, and shared
design files. Future tasks should replace the placeholder onboarding and tab
content surfaces through approved task files.

## 3. Source File Record Template

```text
Path:
Feature:
Layer:
Kind:
Owner Task:
Public Symbols:
Depends On:
Referenced By:
Related Routes:
Related Function IDs:
Related DTO IDs:
Related Tests:
Status:
Notes:
```

## 4. Planned Source Roots

Create roots only when the current architecture stage needs real files.

```text
lib/app/
lib/common/
lib/features/
test/
integration_test/
```

## 5. Planned Layer Roots

| Path Pattern | Layer | Rule |
| --- | --- | --- |
| `lib/app/` | App composition | App bootstrap, dependency composition, router, lifecycle. |
| `lib/common/design/` | Design system | Shared colors, spacing, typography, radii, theme. |
| `lib/common/preview/` | Preview support | Shared widget preview annotations, wrappers, and default sizing. |
| `lib/common/widgets/` | Shared UI | Reusable app widgets only. |
| `lib/common/routing/` | Routing | Shared route models/helpers. |
| `lib/features/<feature>/presentation/` | Presentation | Pages, widgets, controllers/view models. |
| `lib/features/<feature>/application/` | Application | Use cases and feature services. |
| `lib/features/<feature>/domain/` | Domain | Models, policies, repository/service protocols. |
| `lib/features/<feature>/data/` | Data | Mock/remote services, DTO adapters, repositories. |
| `test/` | Tests | Unit and widget tests. |
| `integration_test/` | Integration tests | End-to-end app flows. |

Early view-first tasks may use a flatter feature folder. Promote files into
presentation/application/domain/data only when the task records the architecture
evolution reason.

## 6. Current Source File Inventory

```text
Path: lib/main.dart
Feature: app_shell
Layer: App entrypoint
Kind: Flutter entrypoint
Owner Task: 001A_app_page_switching_shell, 001B_app_page_shell_persistence, 001C_tabbar_page_items
Public Symbols: main, MyApp
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, core/app_page/app_page.dart, core/app_page/app_page_shell_storage.dart
Referenced By: Flutter runtime
Related Routes: ROUTE-APP-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Boots the Cupertino-themed app, renders AppPage as the home surface, and
allows tests or future bootstrap code to inject the AppPage shell storage.

Path: lib/core/app_page/app_page.dart
Feature: app_shell
Layer: App shell presentation
Kind: root page widget
Owner Task: 001A_app_page_switching_shell, 001B_app_page_shell_persistence, 001C_tabbar_page_items, 001D_welcome_onboarding_flow, 001E_profile_settings_logout
Public Symbols: AppPage, AppPageBuilder, appPagePreview, appPageBuilderOnboardingPreview, appPageBuilderTabbarPreview, tabBarPlaceholderPreview, fullScreenPanelPreview
Depends On: dart:async, flutter/cupertino.dart, common/design/app_colors.dart, common/preview/app_preview.dart, core/app_page/app_page_shell_storage.dart, core/tabbar_page/tabbar_page.dart, core/welcome_page/welcome_page.dart
Referenced By: lib/main.dart, test/widget_test.dart
Related Routes: ROUTE-APP-001
Related Function IDs: FN-APP-002, FN-APP-003
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Cupertino view-first shell with persisted onboarding/tabbar state.
AppPage owns state restoration/persistence through AppPageShellStorage, but
does not toggle from whole-page taps. WelcomePage owns the onboarding action
that switches into the static TabbarPage, while SettingsPage logout returns the
shell to onboarding by resetting the same temporary preference. AppPageBuilder
owns the directional slide transition.

Path: lib/core/app_page/app_page_shell_storage.dart
Feature: app_shell
Layer: App shell persistence adapter
Kind: local preference storage boundary
Owner Task: 001B_app_page_shell_persistence
Public Symbols: AppPageShellStorage, SharedPreferencesAppPageShellStorage
Depends On: shared_preferences/shared_preferences.dart
Referenced By: lib/main.dart, lib/core/app_page/app_page.dart, test/widget_test.dart
Related Routes: ROUTE-APP-001
Related Function IDs: FN-APP-002, FN-APP-003
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Stores the temporary `app_page.show_tab_bar` shell preference through
SharedPreferencesAsync. This is not the final auth/session/onboarding state.

Path: lib/core/tabbar_page/tabbar_page.dart
Feature: app_shell
Layer: App shell presentation
Kind: tab shell widget
Owner Task: 001C_tabbar_page_items, 001E_profile_settings_logout, 001F_tabbar_depth_and_button_component
Public Symbols: TabbarPage, tabbarPagePreview
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/preview/app_preview.dart, core/chats_page/chats_page.dart, core/explore_page/explore_page.dart, core/profile_page/profile_page.dart
Referenced By: lib/core/app_page/app_page.dart, test/widget_test.dart
Related Routes: ROUTE-TAB-002, ROUTE-TAB-003, ROUTE-TAB-004
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Provides a custom Cupertino tab shell with three static items: Explore,
Chats, and Profile. Each tab keeps its own CupertinoTabView navigator. The
tabbar slides/fades out when the active tab pushes a second-level route and
slides/fades back in when the active tab returns to its root page.

Path: lib/core/explore_page/explore_page.dart
Feature: app_shell
Layer: App shell presentation
Kind: tab content page
Owner Task: 001C_tabbar_page_items
Public Symbols: ExplorePage, explorePagePreview
Depends On: flutter/cupertino.dart, common/preview/app_preview.dart
Referenced By: lib/core/tabbar_page/tabbar_page.dart
Related Routes: ROUTE-TAB-002
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Placeholder Explore tab page with a Cupertino navigation title and
centered page name.

Path: lib/core/chats_page/chats_page.dart
Feature: app_shell
Layer: App shell presentation
Kind: tab content page
Owner Task: 001C_tabbar_page_items
Public Symbols: ChatsPage, chatsPagePreview
Depends On: flutter/cupertino.dart, common/preview/app_preview.dart
Referenced By: lib/core/tabbar_page/tabbar_page.dart
Related Routes: ROUTE-TAB-003
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Placeholder Chats tab page with a Cupertino navigation title and
centered page name.

Path: lib/core/profile_page/profile_page.dart
Feature: profile, settings
Layer: App shell presentation
Kind: tab content page
Owner Task: 001C_tabbar_page_items, 001E_profile_settings_logout
Public Symbols: ProfilePage, profilePagePreview
Depends On: flutter/cupertino.dart, common/preview/app_preview.dart, core/settings_page/settings_page.dart
Referenced By: lib/core/tabbar_page/tabbar_page.dart
Related Routes: ROUTE-TAB-004, ROUTE-SETTINGS-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Placeholder Profile tab page with a Cupertino navigation title and
centered page name. The top-right Settings nav item pushes SettingsPage inside
the profile tab navigator.

Path: lib/core/settings_page/settings_page.dart
Feature: settings
Layer: App shell presentation
Kind: settings page
Owner Task: 001E_profile_settings_logout, 001F_tabbar_depth_and_button_component
Public Symbols: SettingsPage, settingsPagePreview
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/design/app_spacing.dart, common/preview/app_preview.dart, common/widgets/app_primary_action_button.dart
Referenced By: lib/core/profile_page/profile_page.dart, test/widget_test.dart
Related Routes: ROUTE-SETTINGS-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: View-first Settings page with nav title, centered page name, and a
Logout button. Logout disables the button, waits one second, then notifies
AppPage through the callback chain so the shell returns to onboarding.

Path: lib/core/welcome_page/welcome_page.dart
Feature: onboarding
Layer: App shell presentation
Kind: onboarding page
Owner Task: 001D_welcome_onboarding_flow
Public Symbols: WelcomePage, welcomePagePreview
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/design/app_spacing.dart, common/preview/app_preview.dart, common/widgets/app_primary_action_button.dart, core/onboarding/completed_page/onboard_completed_page.dart
Referenced By: lib/core/app_page/app_page.dart, test/widget_test.dart
Related Routes: ROUTE-TAB-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Placeholder welcome page with centered `Welcome!` text and a bottom Get
Started button that pushes OnboardCompletedPage.

Path: lib/core/onboarding/completed_page/onboard_completed_page.dart
Feature: onboarding
Layer: App shell presentation
Kind: onboarding completion page
Owner Task: 001D_welcome_onboarding_flow
Public Symbols: OnboardCompletedPage, onboardCompletedPagePreview
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/design/app_spacing.dart, common/preview/app_preview.dart, common/widgets/app_primary_action_button.dart
Referenced By: lib/core/welcome_page/welcome_page.dart, test/widget_test.dart
Related Routes: ROUTE-ONBOARDING-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Placeholder onboarding completion page with nav title, centered page
name, and a Completed button that notifies AppPage when used in the root flow.

Path: lib/common/preview/app_preview.dart
Feature: app_shell
Layer: Preview support
Kind: shared preview helpers
Owner Task: 001A_app_page_switching_shell
Public Symbols: AppPreviewSizes, appPreviewWrapper, AppPagePreview, AppComponentPreview
Depends On: flutter/cupertino.dart, flutter/widget_previews.dart, common/design/app_colors.dart
Referenced By: lib/core/app_page/app_page.dart, lib/core/tabbar_page/tabbar_page.dart, lib/core/explore_page/explore_page.dart, lib/core/chats_page/chats_page.dart, lib/core/profile_page/profile_page.dart, lib/core/settings_page/settings_page.dart, lib/core/welcome_page/welcome_page.dart, lib/core/onboarding/completed_page/onboard_completed_page.dart, and future page/component preview entries
Related Routes: all UI routes
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: flutter analyze
Status: implemented
Notes: Centralizes Cupertino preview wrapping and default page/component preview sizes so each page/component keeps its own preview without repeating boilerplate.

Path: lib/common/widgets/app_primary_action_button.dart
Feature: common, onboarding, settings
Layer: Shared UI
Kind: reusable button widget
Owner Task: 001F_tabbar_depth_and_button_component
Public Symbols: AppPrimaryActionButton
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/design/app_radii.dart
Referenced By: lib/core/welcome_page/welcome_page.dart, lib/core/onboarding/completed_page/onboard_completed_page.dart, lib/core/settings_page/settings_page.dart
Related Routes: ROUTE-TAB-001, ROUTE-ONBOARDING-001, ROUTE-SETTINGS-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Shared full-width primary action button with a red default background
and explicit white text for contrast.

Path: test/widget_test.dart
Feature: app_shell
Layer: Tests
Kind: widget smoke test
Owner Task: 001A_app_page_switching_shell, 001B_app_page_shell_persistence, 001C_tabbar_page_items, 001D_welcome_onboarding_flow, 001E_profile_settings_logout, 001F_tabbar_depth_and_button_component
Public Symbols: AppPage ignores page taps and switches after onboarding exit test, AppPage restores persisted tabbar state test, Settings logout returns AppPage to onboarding test, WelcomePage opens onboarding completed page test, TabbarPage renders three static items test
Depends On: flutter/cupertino.dart, flutter_test, core/app_page/app_page_shell_storage.dart, core/tabbar_page/tabbar_page.dart, core/welcome_page/welcome_page.dart, main.dart
Referenced By: flutter test
Related Routes: ROUTE-APP-001, ROUTE-SETTINGS-001
Related Function IDs: FN-APP-002, FN-APP-003
Related DTO IDs: none
Related Tests: self
Status: implemented
Notes: Verifies AppPage ignores arbitrary page taps, switches to tabbar through
the onboarding completion action, persists/restores tabbar state, opens the
Welcome -> completed page flow, checks primary button white text, verifies
Settings hides the tabbar on the second-level route and returns to onboarding,
and renders static Explore/Chats/Profile tab pages.

Path: lib/common/design/app_colors.dart
Feature: app_shell
Layer: Design system
Kind: color tokens
Owner Task: pre-ai_dev project setup
Public Symbols: AppColors
Depends On: dart:ui
Referenced By: AppTheme, AppPage, MyApp
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Shared color tokens. Uses `dart:ui` only so UI code can consume tokens without importing Material.

Path: lib/common/design/app_radii.dart
Feature: app_shell
Layer: Design system
Kind: radius tokens
Owner Task: pre-ai_dev project setup
Public Symbols: AppRadii
Depends On: none
Referenced By: future UI
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Shared radius tokens.

Path: lib/common/design/app_spacing.dart
Feature: app_shell
Layer: Design system
Kind: spacing tokens
Owner Task: pre-ai_dev project setup
Public Symbols: AppSpacing
Depends On: none
Referenced By: future UI
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Shared spacing tokens.

Path: lib/common/design/app_theme.dart
Feature: app_shell
Layer: Design system
Kind: Material theme
Owner Task: pre-ai_dev project setup
Public Symbols: AppTheme
Depends On: AppColors, AppTextStyles
Referenced By: design.dart and future Material surfaces only
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Defines light and dark themes.

Path: lib/common/design/app_typography.dart
Feature: app_shell
Layer: Design system
Kind: typography tokens
Owner Task: pre-ai_dev project setup
Public Symbols: AppFontFamilies, AppTextStyles
Depends On: flutter/widgets.dart
Referenced By: AppTheme
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Shared text styles.

Path: lib/common/design/design.dart
Feature: app_shell
Layer: Design system
Kind: barrel export
Owner Task: pre-ai_dev project setup
Public Symbols: design exports
Depends On: design token files
Referenced By: lib/main.dart
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Barrel export for design foundation.
```

## 7. Tooling File Inventory

These are aidev template tooling files, not Flutter application source files.

```text
Path: bin/aidev
Feature: aidev tooling
Layer: CLI
Kind: shell wrapper
Owner Task: 000G_aidev_validation_tooling
Public Symbols: aidev check command entrypoint
Depends On: tools/aidev_check.py, python3
Referenced By: README.md, .github/workflows/aidev-check.yml
Related Tests: ./bin/aidev check
Status: implemented

Path: tools/aidev_check.py
Feature: aidev tooling
Layer: Validator
Kind: Python script
Owner Task: 000G_aidev_validation_tooling
Public Symbols: check command, task/index/git/source validation functions
Depends On: Python standard library, git command when available
Referenced By: bin/aidev
Related Tests: python3 -m py_compile tools/aidev_check.py; ./bin/aidev check
Status: implemented
```
