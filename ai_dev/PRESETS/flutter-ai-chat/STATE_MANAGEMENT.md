# Flutter AI Chat State Management Rules

## 1. Purpose

This document defines state-management expectations for Flutter AI chat apps.

It does not mandate a specific package. The project overlay must record the
selected package and why.

It also does not mandate MVVM from day one. State management should evolve with
the architecture stage described in `ARCHITECTURE.md`.

## 2. State Categories

Separate these categories:

- App state: boot, theme mode, environment, auth session.
- Navigation state: current route, tab, nested route stack.
- Feature state: page view model/controller state.
- Domain state: chat session, messages, user, avatar, entitlement.
- Ephemeral UI state: input text, focus, transient animation.
- Remote/cache state: loading, refresh, stale data, error.

Do not store everything in one global object.

## 3. Evolution Stages

Acceptable state ownership by stage:

| Stage | State Owner | Typical Use |
| --- | --- | --- |
| View-first | local widget state | static UI, tab selection, simple input. |
| MV | model objects and small helpers | repeated data shape or rendering helpers. |
| MVVM/controller | view model/controller | loading/error/data state, user intents, testable screen logic. |
| Manager | feature manager | shared lifecycle or coordination across screens/controllers. |
| Service/use case | service/use case | remote calls, business workflow, reusable behavior. |
| DI/router/interactor | composition/router/interactor | environment swapping, cross-feature flow, route ownership. |

Do not promote state to a higher stage without a task-level reason.

## 4. View Model / Controller Rules

When the project reaches MVVM/controller stage, feature controllers or view
models should:

- Own screen state and user intents.
- Call use cases or services.
- Expose immutable or controlled state.
- Map domain/application errors to UI-safe state.
- Be testable without rendering a widget.

They should not:

- Perform raw SDK calls.
- Depend on concrete remote services when a protocol exists.
- Hold BuildContext except for unavoidable framework callbacks.

## 5. Async State

Async state must represent at least:

- idle or initial.
- loading.
- data.
- empty when distinct from data.
- error with safe user-facing message.

Chat-specific async states should also handle:

- sending message.
- generating reply.
- streaming partial reply.
- retryable failure.
- cancellation.

## 6. List and Chat Performance

Chat/message lists should:

- Use stable message IDs.
- Avoid unnecessary full-list rebuilds.
- Keep input composer state independent from list rendering.
- Use pagination or lazy loading when message history grows.
- Preserve scroll behavior during insertions and streaming updates.

## 7. Package Selection

The project may use Riverpod, Bloc, Provider, ValueNotifier, ChangeNotifier, or
another package, but the selection must be recorded in `PROJECT/DECISION_LOG.md`
before non-trivial source work depends on it.

Selection criteria:

- Testability.
- Clear dependency ownership.
- Async state ergonomics.
- Compatibility with source-history rewrite goals.
- Team familiarity.
- Long-term maintainability.

## 8. Migration Discipline

When rewriting from another app history, do not jump directly to the final state
management architecture unless the task explicitly represents that architecture
step.

If the source app evolves from simple views to MVVM, then to a stronger routing
or interactor model, the Flutter rewrite should preserve that learning path in
task documentation.
