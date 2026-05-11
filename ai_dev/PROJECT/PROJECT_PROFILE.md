# Project Profile

## 1. Identity

Project name: flutter_ai_chat

Project type:

- Flutter mobile application.
- AI chat client.
- Source-history rewrite target for the existing AIChats iOS project.

Primary framework:

- Flutter.
- Dart.

Business domain:

- AI chat.
- Avatar/character discovery.
- Chat sessions and message generation.
- Onboarding, profile, settings, analytics, experiments, and paywall as the app
  evolves.

## 2. Enabled Layers

Core:

- `ai_dev/CORE/`

Presets:

- `ai_dev/PRESETS/flutter-ai-chat/`

Project overlay:

- `ai_dev/PROJECT/`

## 3. Source Rewrite Intent

The project should rebuild the existing AIChats product in Flutter while
preserving the development learning path.

The rewrite should track source project updates by task:

```text
AIChats source commit/range
-> product behavior
-> architecture change
-> Flutter equivalent implementation
-> verification and index updates
```

The goal is not a mechanical file translation. The goal is to recreate product
features and architecture evolution in a Flutter-native way.

Architecture is not preselected as MVVM, VIPER, RIB, or any other final model.
The project should start with the smallest runnable structure and evolve only
when feature complexity creates a concrete reason.

## 4. First-Phase Route

The first phase should establish:

```text
Flutter app shell
-> design system
-> tab shell
-> Welcome / Explore / Chats / Profile placeholders
-> source-history task mapping
-> simple view-first feature implementation
-> MV / MVVM / Manager / Service / DI / Router evolution when justified
-> mock-first AI chat domain
-> incremental feature rewrite from AIChats
-> final architecture summary and lessons learned
```

## 5. First-Phase Task Line

```text
000_project_rules_and_architecture
000A_ai_development_workflow
000B_learning_extensions
000C_extension_governance
000D_aidev_layered_template
000E_aidev_contract_indexes
000F_git_workflow_modes
001_flutter_ai_chat_foundation
002_aichats_source_history_map
003_app_shell_and_static_tabs
004_mock_chat_domain
005_feature_rewrite_from_source_history
```

## 6. Project-Specific Priorities

- Preserve the AIChats architecture evolution as task evidence.
- Prefer Flutter-native structure over SwiftUI file-by-file translation.
- Avoid locking the project into a final architecture before the history reaches
  that stage.
- Introduce MV, MVVM, Manager, Service, DI, Router, VIPER, or RIB-style
  boundaries only when the task records the reason.
- Keep mock services available before remote/provider work.
- Keep UI, state, service, routing, and provider responsibilities separated.
- Keep design system work reusable across onboarding, explore, chats, profile,
  settings, and paywall.
- Do not introduce provider credentials or AI API keys into source control.
- Keep each rewrite task traceable to source commit evidence.

## 7. Current Open Decisions

See:

- `ai_dev/PROJECT/DECISION_LOG.md`
- `ai_dev/PROJECT/RISK_REGISTER.md`
