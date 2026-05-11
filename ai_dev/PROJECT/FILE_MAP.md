# File Map

## 1. Purpose

This file is the path-level source file map for the current Flutter AI Chat
project.

`IMPLEMENTATION_MAP.md` explains architecture placement and implemented source
coverage. `FILE_MAP.md` is the mechanical inventory future AI agents should
update whenever files are created, moved, or deleted.

## 2. Current Status

Status: Flutter starter plus design-token foundation exists.

The app currently has a Flutter starter entrypoint and shared design files.
Future tasks should replace the demo counter screen through approved task files.

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
| `lib/common/widgets/` | Shared UI | Reusable app widgets only. |
| `lib/common/routing/` | Routing | Shared route models/helpers. |
| `lib/features/<feature>/presentation/` | Presentation | Pages, widgets, controllers/view models. |
| `lib/features/<feature>/application/` | Application | Use cases and feature services. |
| `lib/features/<feature>/domain/` | Domain | Models, policies, repository/service protocols. |
| `lib/features/<feature>/data/` | Data | Mock/remote services, DTO adapters, repositories. |
| `test/` | Tests | Unit and widget tests. |
| `integration_test/` | Integration tests | End-to-end app flows. |

## 6. Current Source File Inventory

```text
Path: lib/main.dart
Feature: app_shell
Layer: App entrypoint
Kind: Flutter entrypoint
Owner Task: pre-ai_dev project setup
Public Symbols: main, MyApp, MyHomePage
Depends On: flutter/material.dart, common/design/design.dart
Referenced By: Flutter runtime
Related Routes: ROUTE-APP-001
Related Function IDs: none yet
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Still contains Flutter counter demo; future foundation task should replace it with the app shell.

Path: lib/common/design/app_colors.dart
Feature: app_shell
Layer: Design system
Kind: color tokens
Owner Task: pre-ai_dev project setup
Public Symbols: AppColors
Depends On: flutter/material.dart
Referenced By: AppTheme
Related Routes: all UI routes
Related Function IDs: none
Related DTO IDs: none
Related Tests: none yet
Status: implemented
Notes: Shared color tokens.

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
Referenced By: MyApp
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
Depends On: flutter/material.dart
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
