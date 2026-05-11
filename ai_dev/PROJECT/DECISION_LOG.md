# Decision Log

## 1. Purpose

This file records durable project decisions for the Flutter AI Chat rewrite.

Do not store transient discussion here. Add entries when a decision affects
future implementation, architecture, verification, or task ordering.

## 2. Decision Record Template

```text
### D-0000 Title

Date:
Status: proposed | accepted | superseded

Context:

Decision:

Consequences:

Alternatives Considered:

References:
```

## 3. Decisions

### D-0001 Use Flutter AI Chat preset as active project preset

Date: 2026-05-11
Status: accepted

Context:

The imported ai_dev template contained Vapor backend and cross-border ecommerce
presets as active project guidance, but the current repository is a Flutter AI
Chat app.

Decision:

Use `ai_dev/PRESETS/flutter-ai-chat/` as the active preset for this project.
Keep Vapor and ecommerce presets available as reusable templates, but do not
enable them for the current Flutter project.

Consequences:

- Future tasks should read Flutter AI Chat preset docs before implementation.
- Project overlay indexes should describe Flutter features, routes, state,
  service contracts, and source-history rewrite evidence.
- Backend/ecommerce rules do not govern current Flutter source work.

Alternatives Considered:

- Delete Vapor/ecommerce presets entirely. Rejected because presets can remain
  useful templates for other projects.

References:

- `ai_dev/AIDEV_MANIFEST.md`
- `ai_dev/PRESETS/flutter-ai-chat/`

### D-0002 Rebuild AIChats by source-history intent, not file-by-file translation

Date: 2026-05-11
Status: accepted

Context:

The product goal is to rewrite a satisfactory AIChats iOS project in Flutter
while preserving normal feature development and architecture evolution.

Decision:

Each rewrite task should map source commit/range evidence to product behavior
and architecture intent, then implement the Flutter-native equivalent.

Consequences:

- Early Flutter tasks should not jump directly to the final AIChats architecture
  unless the task explicitly represents that source-history stage.
- Task files must record source repo, source branch, source commit/range, product
  goal, architecture change, Flutter equivalent, and verification.

Alternatives Considered:

- Translate current `main` directly. Rejected because it loses the architecture
  evolution learning goal.

References:

- `ai_dev/PRESETS/flutter-ai-chat/SOURCE_HISTORY_REWRITE.md`

### D-0003 Defer final state-management and routing package choices

Date: 2026-05-11
Status: accepted

Context:

The current Flutter app is still near starter state. Choosing a final state
management or routing package before the first source-history mapping may
overfit the architecture.

Decision:

Defer final package choices until the first implementation task needs them.
Record the decision before non-trivial code depends on a package.

Consequences:

- Early task files may use simple Flutter-native structures.
- Once selected, package choices must update project rules, implementation map,
  function signatures, tests, and risk register as needed.

Alternatives Considered:

- Immediately mandate Riverpod/go_router. Rejected until source-history and
  current repo needs are confirmed.

References:

- `ai_dev/PRESETS/flutter-ai-chat/STATE_MANAGEMENT.md`
