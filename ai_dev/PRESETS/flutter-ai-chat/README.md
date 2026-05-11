# Flutter AI Chat Preset

## 1. Purpose

This preset defines reusable rules for Flutter applications in the AI chat
category.

It is intended for projects that need:

- A Flutter mobile app foundation.
- AI chat sessions and message UI.
- Local mock-first development.
- Future remote AI provider integration.
- Clear feature, state, service, routing, and test boundaries.
- Optional source-history rewrite from an existing iOS/SwiftUI app.

Project-specific product names, source repositories, route names, API keys,
models, visual copy, and launch decisions belong in `ai_dev/PROJECT/`.

## 2. Preset Files

```text
ai_dev/PRESETS/flutter-ai-chat/README.md
ai_dev/PRESETS/flutter-ai-chat/ARCHITECTURE.md
ai_dev/PRESETS/flutter-ai-chat/AI_CHAT_DOMAIN.md
ai_dev/PRESETS/flutter-ai-chat/STATE_MANAGEMENT.md
ai_dev/PRESETS/flutter-ai-chat/OBSERVABILITY_RULES.md
ai_dev/PRESETS/flutter-ai-chat/TESTING_RULES.md
ai_dev/PRESETS/flutter-ai-chat/SOURCE_HISTORY_REWRITE.md
```

## 3. Use This Preset When

Use this preset when the current project is primarily:

- Flutter app development.
- AI chat UX and conversation workflows.
- Chat, avatar, onboarding, profile, settings, paywall, analytics, or experiment
  features.
- Rebuilding or porting an AI chat product from another client stack.

Do not use this preset for backend-only services, admin-only web apps, or
non-chat mobile apps unless the task explicitly adapts it.

## 4. Layer Ownership

This preset owns reusable Flutter AI chat guidance:

- Feature-oriented Flutter source layout.
- UI/state/data layering.
- Chat and AI provider contracts.
- Mock-first service boundaries.
- Routing and dependency injection rules.
- Flutter verification gates.
- Source-history rewrite discipline.

The project overlay owns current-project details:

- Source app and branch/commit mapping.
- Current Flutter package name.
- Selected state management package.
- Active feature roadmap.
- Actual file map and task order.
- API/provider keys and environment policy.
- Visual design decisions.

