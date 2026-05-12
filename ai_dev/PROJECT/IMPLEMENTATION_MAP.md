# Implementation Map

## 1. Purpose

This file maps implemented source files to Flutter features and architectural
layers. It prevents the project from drifting away from `AIDEV_MANIFEST.md`,
root `PROJECT_RULES.md`, project overlay rules, and active presets.

Every task that adds, moves, or deletes source files must update this file.

## 2. Current Implementation Status

Status: Flutter view-first root page, narrow shell preference persistence,
static three-item tabbar page with route-depth tabbar hiding,
profile/settings logout flow, shared primary action button, and ai_dev Flutter
AI Chat preset.

Current app source:

```text
lib/main.dart
lib/core/app_page/app_page.dart
lib/core/app_page/app_page_shell_storage.dart
lib/core/tabbar_page/tabbar_page.dart
lib/core/explore_page/explore_page.dart
lib/core/chats_page/chats_page.dart
lib/core/profile_page/profile_page.dart
lib/core/settings_page/settings_page.dart
lib/core/welcome_page/welcome_page.dart
lib/core/onboarding/completed_page/onboard_completed_page.dart
lib/common/widgets/app_primary_action_button.dart
lib/common/design/app_colors.dart
lib/common/design/app_radii.dart
lib/common/design/app_spacing.dart
lib/common/design/app_theme.dart
lib/common/design/app_typography.dart
lib/common/design/design.dart
```

Current tests:

```text
test/widget_test.dart
```

Current ai_dev preset and project docs:

```text
ai_dev/AIDEV_MANIFEST.md
ai_dev/PROJECT_RULES.md
ai_dev/PRESETS/flutter-ai-chat/README.md
ai_dev/PRESETS/flutter-ai-chat/ARCHITECTURE.md
ai_dev/PRESETS/flutter-ai-chat/AI_CHAT_DOMAIN.md
ai_dev/PRESETS/flutter-ai-chat/STATE_MANAGEMENT.md
ai_dev/PRESETS/flutter-ai-chat/OBSERVABILITY_RULES.md
ai_dev/PRESETS/flutter-ai-chat/TESTING_RULES.md
ai_dev/PRESETS/flutter-ai-chat/SOURCE_HISTORY_REWRITE.md
ai_dev/PROJECT/PROJECT_PROFILE.md
ai_dev/PROJECT/PROJECT_RULES.md
ai_dev/PROJECT/GIT_WORKFLOW.md
ai_dev/PROJECT/FEATURE_MAP.md
ai_dev/PROJECT/FILE_MAP.md
ai_dev/PROJECT/IMPLEMENTATION_MAP.md
ai_dev/PROJECT/API_ROUTE_MAP.md
ai_dev/PROJECT/FUNCTION_SIGNATURE_INDEX.md
ai_dev/PROJECT/DTO_CONTRACT_INDEX.md
ai_dev/PROJECT/PERMISSION_INDEX.md
ai_dev/PROJECT/STATE_MACHINE_INDEX.md
ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md
ai_dev/PROJECT/ADMIN_FRONTEND_MAP.md
ai_dev/PROJECT/CONFIG_ENV_INDEX.md
ai_dev/PROJECT/TRACEABILITY_MATRIX.md
ai_dev/PROJECT/DECISION_LOG.md
ai_dev/PROJECT/RISK_REGISTER.md
```

## 3. Planned Flutter Roots

```text
lib/app/
lib/common/
lib/features/
test/
integration_test/
```

## 4. Planned Foundation Areas

Foundation should eventually include:

- App bootstrap and dependency composition.
- Router setup.
- Theme and design system.
- Environment selection.
- Mock-first service registration.
- Safe logging and analytics facade.
- Feature shell and tab navigation.
- Test utilities.

Foundation code must not contain provider credentials or product-specific AI
provider SDK calls.

Do not create every foundation area up front. Add each area when the current
architecture stage and task evidence justify it.

Currently implemented foundation coverage:

```text
lib/main.dart -> CupertinoApp bootstrap with shared colors and AppPage home.
lib/common/preview/app_preview.dart -> shared Cupertino widget preview wrapper and default page/component preview sizes.
lib/core/app_page/app_page.dart -> Cupertino view-first AppPage state shell, persisted shell state restore/save, reusable AppPageBuilder transition component, page-controlled WelcomePage -> TabbarPage switching, Settings logout -> onboarding switching, and shared @AppPagePreview entries.
lib/core/app_page/app_page_shell_storage.dart -> SharedPreferencesAsync-backed storage adapter for the temporary AppPage shell preference.
lib/core/tabbar_page/tabbar_page.dart -> custom Cupertino tab shell with Explore, Chats, and Profile static tab items, per-tab CupertinoTabView navigators, route-depth driven tabbar slide/fade hiding, logout callback handoff, and preview.
lib/core/explore_page/explore_page.dart -> placeholder Explore page with nav title and centered page name.
lib/core/chats_page/chats_page.dart -> placeholder Chats page with nav title and centered page name.
lib/core/profile_page/profile_page.dart -> placeholder Profile page with nav title, top-right Settings nav item, and centered page name.
lib/core/settings_page/settings_page.dart -> placeholder Settings page with one-second async Logout return to onboarding.
lib/core/welcome_page/welcome_page.dart -> placeholder Welcome page with Get Started navigation to onboarding completion.
lib/core/onboarding/completed_page/onboard_completed_page.dart -> placeholder onboarding completion page with Completed action.
lib/common/widgets/app_primary_action_button.dart -> shared full-width red primary action button with explicit white text.
test/widget_test.dart -> AppPage page-controlled switch, persistence restore, Welcome flow, Settings logout/tabbar hiding flow, primary button contrast, and static tabbar smoke tests.
```

## 5. Planned Feature Modules

Each feature should follow the evolution rules in
`ai_dev/PRESETS/flutter-ai-chat/ARCHITECTURE.md`.

These roots are planned capacity, not mandatory first-step folders.

```text
lib/features/onboarding/
lib/features/explore/
lib/features/avatar/
lib/features/chats/
lib/features/chat/
lib/features/profile/
lib/features/settings/
lib/features/paywall/
lib/features/dev_settings/
lib/features/analytics/
lib/features/experiments/
```

## 6. Module File Map Template

When a feature is implemented, add entries like:

```text
Feature: chat
Presentation:
  - lib/features/chat/presentation/pages/chat_page.dart
  - lib/features/chat/presentation/controllers/chat_controller.dart
Application:
  - lib/features/chat/application/use_cases/send_message.dart
Domain:
  - lib/features/chat/domain/models/chat_message.dart
  - lib/features/chat/domain/services/ai_chat_service.dart
Data:
  - lib/features/chat/data/services/mock_ai_chat_service.dart
Tests:
  - test/features/chat/chat_controller_test.dart
  - test/features/chat/chat_page_test.dart
```

## 7. Update Rules

Update this file when:

- A Flutter source file is created, moved, renamed, or deleted.
- A feature changes architecture layer placement.
- A generated file becomes part of the committed source contract.
- A task changes route, state, data, service, or test ownership.
