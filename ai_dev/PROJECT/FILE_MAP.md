# File Map

## 1. Purpose

This file is the path-level source file map for the current Flutter AI Chat
project.

`IMPLEMENTATION_MAP.md` explains architecture placement and implemented source
coverage. `FILE_MAP.md` is the mechanical inventory future AI agents should
update whenever files are created, moved, or deleted.

## 2. Current Status

Status: Flutter view-first root page plus design-token foundation exists.

The app currently has a Flutter entrypoint, `AppPage` root shell placeholder,
widget smoke coverage, and shared design files. Future tasks should replace the
placeholder tabbar/onboarding surfaces through approved task files.

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
Owner Task: 001A_app_page_switching_shell
Public Symbols: main, MyApp
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, core/app_page.dart
Referenced By: Flutter runtime
Related Routes: ROUTE-APP-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Boots the Cupertino-themed app and renders AppPage as the home surface.

Path: lib/core/app_page.dart
Feature: app_shell
Layer: App shell presentation
Kind: root page widget
Owner Task: 001A_app_page_switching_shell
Public Symbols: AppPage, appPagePreview, onboardingPlaceholderPreview, tabBarPlaceholderPreview, fullScreenPanelPreview
Depends On: flutter/cupertino.dart, common/design/app_colors.dart, common/preview/app_preview.dart
Referenced By: lib/main.dart, test/widget_test.dart
Related Routes: ROUTE-APP-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: test/widget_test.dart
Status: implemented
Notes: Cupertino view-first placeholder shell with local onboarding/tabbar toggle, directional slide transition, and shared widget previews for the page and placeholder components.

Path: lib/common/preview/app_preview.dart
Feature: app_shell
Layer: Preview support
Kind: shared preview helpers
Owner Task: 001A_app_page_switching_shell
Public Symbols: AppPreviewSizes, appPreviewWrapper, AppPagePreview, AppComponentPreview
Depends On: flutter/cupertino.dart, flutter/widget_previews.dart, common/design/app_colors.dart
Referenced By: lib/core/app_page.dart and future page/component preview entries
Related Routes: all UI routes
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: flutter analyze
Status: implemented
Notes: Centralizes Cupertino preview wrapping and default page/component preview sizes so each page/component keeps its own preview without repeating boilerplate.

Path: test/widget_test.dart
Feature: app_shell
Layer: Tests
Kind: widget smoke test
Owner Task: 001A_app_page_switching_shell
Public Symbols: AppPage switches from onboarding to tabbar on tap test
Depends On: flutter_test, main.dart
Referenced By: flutter test
Related Routes: ROUTE-APP-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: self
Status: implemented
Notes: Verifies the current AppPage placeholder shell interaction and directional mid-transition state.

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
