# Project Overlay Rules

## 1. Purpose

This file contains rules specific to the current Flutter AI Chat rewrite
project.

Reusable workflow rules belong in `ai_dev/CORE/`.

Reusable Flutter AI chat rules belong in
`ai_dev/PRESETS/flutter-ai-chat/`.

## 2. First-Phase Scope

The first phase must build one reliable Flutter foundation route:

```text
app shell
-> design system
-> tab shell
-> source-history mapping
-> mock-first chat domain
-> incremental AIChats feature rewrite
```

Do not attempt to rebuild the entire current AIChats `main` branch in one task.

## 3. Source-History Rewrite Rule

When a task follows the source AIChats history, it must record:

- Source repository.
- Source branch.
- Source commit or commit range.
- Source product goal.
- Source architecture change.
- Flutter product goal.
- Flutter architecture change.
- Affected Flutter files.
- Verification gates.
- Index updates.

Translate architecture intent, not SwiftUI files mechanically.

## 4. Architecture Evolution Rule

This project must not lock into a final architecture model at the start.

Every Build task that changes Flutter source should record:

- Current architecture stage.
- Whether the current stage is still enough.
- If a new layer is introduced, the specific pain that requires it.
- The smallest next architecture step.
- The cost or tradeoff introduced by that step.

Valid stage examples include:

```text
starter
view-first
MV
MVVM/controller
Manager
Service
Repository/data boundary
DI
Router
Interactor
VIPER/RIB-style module boundary
```

The expected flow is:

```text
write product code
-> observe repeated complexity
-> evolve architecture one step
-> record the reason
-> summarize what was learned
```

Do not add Manager, Service, DI, Router, VIPER, or RIB-style boundaries before a
task has evidence that the simpler stage is no longer enough.

## 5. Project-Specific Priorities

- Preserve the ordinary feature-development path and architecture evolution.
- Keep the Flutter implementation runnable after each Build task.
- Use mock-first service boundaries for AI, avatar, chat, auth, analytics,
  purchases, experiments, push, and remote content.
- Keep page widgets free from concrete provider SDK calls.
- Keep sensitive data, prompts, user messages, and provider keys out of logs by
  default.
- Keep design tokens and reusable UI primitives under shared design/common
  layers before repeated feature UI grows.

## 6. Project Task Rule

Build work must use an approved task file under `ai_dev/TASKS/`.

Source-code Build work must check `ai_dev/PROJECT/GIT_WORKFLOW.md`.

The current default branch mode is `simple`, but `feature_branch` or
`parallel_ai` may be enabled per project/task when review isolation is needed.

If implementation touches the first-phase route, update
`ai_dev/PROJECT/TRACEABILITY_MATRIX.md`.

If implementation changes current project decisions or risks, update:

- `ai_dev/PROJECT/DECISION_LOG.md`
- `ai_dev/PROJECT/RISK_REGISTER.md`

If implementation creates source files, update:

- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`

If implementation changes feature, route, function, DTO/data, permission, state,
test, config, or source-history contracts, update the matching project index:

- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/API_ROUTE_MAP.md`
- `ai_dev/PROJECT/FUNCTION_SIGNATURE_INDEX.md`
- `ai_dev/PROJECT/DTO_CONTRACT_INDEX.md`
- `ai_dev/PROJECT/PERMISSION_INDEX.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`

## 7. Project Open Questions

Current open questions are tracked in:

- `ai_dev/PROJECT/RISK_REGISTER.md`

Do not silently decide:

- Final Flutter state-management package.
- Final Flutter routing package.
- Remote AI provider and backend shape.
- Whether paywall/purchases are in the first Flutter milestone.
- Which source AIChats commit range defines the first implementation task.
