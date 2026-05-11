# Flutter AI Chat Architecture Evolution Rules

## 1. Purpose

This document defines how architecture should evolve in a Flutter AI chat app.

The project goal is not to apply one fixed architecture from day one. The goal
is to build the product first, let real complexity appear, then introduce the
smallest architecture step that solves the current problem.

Architecture is treated as an output of product development, not a template to
force onto every screen.

## 2. Core Principle

Every implementation task must be able to answer:

```text
What is the current architecture stage?
Why is this stage enough right now?
What pain or complexity would justify the next stage?
Did this task introduce that pain?
If yes, what is the smallest architecture evolution?
```

Do not introduce MVVM, Manager, Service, DI, Router, VIPER, RIB, or another
pattern only because it may be needed later.

## 3. Architecture Stage Ladder

The project may move through these stages. A task can stay at the current stage
or move one step when the reason is documented.

```text
Stage 0: Flutter starter / single app entry
Stage 1: View-first feature code
Stage 2: MV / extracted model and rendering helpers
Stage 3: MVVM / screen state and user intent move into ViewModel or controller
Stage 4: Manager / feature coordination moves out of ViewModel
Stage 5: Service boundary / mock and remote implementations split
Stage 6: Repository or data boundary / persistence and DTO mapping stabilize
Stage 7: DI composition / dependencies are assembled explicitly
Stage 8: Router / route construction and navigation policy separate from pages
Stage 9: Interactor / use-case boundary for cross-feature workflows
Stage 10: VIPER/RIB-style module boundary when feature scale requires it
```

This ladder is descriptive, not mandatory. Some projects may skip a stage, stay
simple for a long time, or choose a different name for the same boundary. The
task must explain the reason.

## 4. Stage Entry Triggers

Use these triggers before adding architecture:

| Stage | Add When | Do Not Add When |
| --- | --- | --- |
| View-first | A screen can be implemented directly and remains readable. | The screen already has remote calls, branching state, or repeated business logic. |
| MV | Data shape is repeated or rendering needs stable models. | The data is one-off display text. |
| MVVM/controller | User actions, loading/error/data state, or tests need separation from widgets. | The page is static or trivially local. |
| Manager | Multiple ViewModels need the same coordination or lifecycle ownership. | Only one screen needs one method. |
| Service | Behavior may become mock/remote or external-provider backed. | The logic is pure local formatting. |
| Repository/data boundary | Persistence, caching, DTO mapping, or source switching becomes real. | There is no stored or remote data. |
| DI | Dependencies become shared, environment-specific, or hard to test manually. | Constructor injection with local objects is still clear. |
| Router | Navigation spans features or route construction becomes duplicated. | A single local callback is clear. |
| Interactor/use case | Workflow crosses features or needs non-UI tests. | The ViewModel only forwards a simple action. |
| VIPER/RIB-style boundary | A feature becomes large enough to need explicit module ownership and navigation/business split. | The feature is still small and readable. |

## 5. Source Layout Is Stage-Dependent

Do not create the full target folder tree before code needs it.

Early acceptable layout:

```text
lib/
  main.dart
  common/design/
```

View-first feature layout:

```text
lib/features/<feature>/
  <feature>_page.dart
  widgets/
```

MVVM/controller stage:

```text
lib/features/<feature>/
  presentation/
    pages/
    widgets/
    controllers/
  domain/
    models/
```

Service/data stage:

```text
lib/features/<feature>/
  application/
  domain/
  data/
    mock/
    remote/
```

Router/DI/interactor stages may add:

```text
lib/app/
  app_router.dart
  app_dependencies.dart
lib/features/<feature>/
  routing/
  application/use_cases/
```

Only create folders that have real files and current ownership.

## 6. Dependency Direction By Stage

Early view-first code may be direct, but it must stay easy to move.

As soon as service or data boundaries exist, follow this direction:

```text
widget/page -> controller/view model -> manager/use case -> service protocol
mock/remote service -> protocol/model contracts
app composition -> concrete dependency wiring
```

Avoid these once boundaries exist:

```text
widget -> concrete remote SDK
domain model -> Flutter BuildContext
service protocol -> concrete mock/remote implementation
remote provider -> UI state object
```

The rule is not "always create every layer". The rule is "when a layer exists,
keep the direction clean".

## 7. Design System Evolution

Design system work can start early because repeated UI cost appears quickly.

Start with:

- Colors.
- Typography.
- Spacing.
- Radii.
- Theme.

Add buttons, inputs, avatars, loading states, and empty states when repeated UI
appears. Do not create a large component library before features need it.

## 8. Routing Evolution

Start with direct navigation or callbacks when simple.

Evolve routing when:

- Multiple features navigate to the same destination.
- A route needs stable parameters.
- Deep links or push notifications target routes.
- Tests need route construction independent from widgets.
- Source-history architecture reaches a router/builder stage.

Do not add a router package only because it is common in Flutter apps.

## 9. Dependency Injection Evolution

Start with direct construction when the app is small.

Move to explicit composition when:

- Mock/dev/prod dependencies differ.
- Tests need to swap services.
- Multiple features share services.
- Environment configuration affects dependency creation.
- Concrete SDK setup should be isolated from UI.

Record any DI package choice in `PROJECT/DECISION_LOG.md` before relying on it.

## 10. Review Rule

Review should reject both extremes:

- Under-architected code that hides real complexity inside widgets.
- Over-architected code that adds layers before the product needs them.

The acceptable solution is the smallest current architecture that keeps the next
known evolution step possible.
