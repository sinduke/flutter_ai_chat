# Source History Rewrite Rules

## 1. Purpose

This document defines how to rebuild an app in Flutter while following the
history of an existing source project.

The goal is to preserve both:

- Product feature development.
- Architecture evolution and the reasons behind it.

## 2. Commit Mapping

Each rewrite task should identify:

- Source repository.
- Source branch.
- Source commit or commit range.
- Product behavior introduced by that commit.
- Architecture change introduced by that commit.
- Flutter equivalent scope.
- Verification gates.

Do not translate files mechanically. Translate the product and architecture
intent.

## 3. Stage Discipline

When the source project evolves through stages, preserve the learning path.

Example stages:

```text
template
-> app shell and static UI
-> feature UI
-> service protocols and mock data
-> remote services
-> logging and observability
-> routing abstraction
-> state management / MVVM
-> interactor or VIPER-style boundaries
```

Do not implement the final architecture during the early tasks unless the task
explicitly says the rewrite is allowed to skip history.

## 4. Task File Requirements

Every source-history rewrite task must include:

```text
Source Repo:
Source Branch:
Source Commit / Range:
Source Product Goal:
Source Architecture Change:
Flutter Product Goal:
Flutter Architecture Change:
Affected Flutter Files:
Verification:
Index Updates:
```

## 5. Architecture Translation

Translate concepts, not framework names.

Examples:

- SwiftUI `View` maps to Flutter page/widget.
- SwiftUI `ViewModel` maps to Flutter controller/view model/state notifier.
- Swift dependency container maps to Flutter dependency composition.
- Swift router/builder maps to Flutter router and route factory.
- Apple/Firebase service protocol maps to Dart abstract service plus mock/remote
  implementations.

If there is no direct equivalent, document the decision in
`PROJECT/DECISION_LOG.md`.

## 6. Verification

Each history step must be independently runnable or explicitly documented as a
documentation-only step.

Do not mark a rewrite step complete unless:

- The Flutter app still analyzes.
- Tests pass or skipped tests are justified.
- The task records the source commit evidence.
- Project indexes reflect new files and feature contracts.

