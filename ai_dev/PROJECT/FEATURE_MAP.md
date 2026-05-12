# Feature Map

## 1. Purpose

This file maps Flutter AI Chat features to source-history evidence, UI routes,
state, services, data contracts, observability, tests, and tasks.

Use this when deciding what to build next and when reviewing whether a task
actually advanced the first-phase rewrite route.

## 2. Status Values

- `planned`
- `contracted`
- `in_progress`
- `implemented`
- `verified`
- `deferred`
- `superseded`

## 3. Feature Contract Template

```text
Feature ID:
Name:
Product Goal:
Primary Actor:
Owning Feature:
Source Commit / Range:
Architecture Stage:
Routes:
State / Controller:
Services:
Data Contracts:
Permissions / Entitlements:
State Machines:
Observability:
Tests:
Related Tasks:
Status:
```

## 4. First-Phase Feature Map

| Feature ID | Name | Actor | Owning Feature | Architecture Stage | Routes | State / Controller | Services | Data | Events | Task | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| F-001 | Flutter AI Chat foundation | user/system | app_shell, common | starter -> view-first | app root | AppPage persisted temporary shell state | local dependencies | theme/design tokens, shared_preferences shell key | none yet | 001A_app_page_switching_shell, 001B_app_page_shell_persistence | implemented |
| F-002 | AIChats source-history map | developer | ai_dev | documentation/control plane | none | none | source history reader | commit map | source_step_mapped | 002_aichats_source_history_map | planned |
| F-003 | App shell and static tabs | user | app_shell | view-first | root tabs | CupertinoTabScaffold local tab state | none | static tab config | none yet | 001C_tabbar_page_items | implemented |
| F-004 | Welcome/onboarding baseline | new user | onboarding | view-first -> MV/MVVM when actions grow | welcome/onboarding | local state or controller | mock user/profile when needed | onboarding state | onboarding_started, onboarding_completed | later source rewrite task | planned |
| F-005 | Explore/avatar discovery baseline | user | explore, avatar | view-first -> Service when mock data repeats | explore, category list | local state or controller | mock avatar service when justified | avatar summary/list | avatar_viewed, avatar_selected | later source rewrite task | planned |
| F-006 | Chats list baseline | user | chats | view-first -> Service when sessions are shared | chats tab | local state or controller | mock chat service when justified | chat session summary | chat_opened | later source rewrite task | planned |
| F-007 | Chat conversation baseline | user | chat | MVVM/controller -> Service when generation appears | chat detail | chat controller | mock AI/chat services | chat message, generation result | message_sent, ai_reply_generated | later source rewrite task | planned |
| F-008 | Profile/settings baseline | user | profile, settings | view-first -> Manager when shared account actions grow | profile/settings | local state or controller | mock auth/user services when needed | user profile | settings_action | later source rewrite task | planned |
| F-009 | Observability baseline | developer/product | analytics | Service boundary when events repeat | all screens | none or analytics helper | console/mock analytics | event payload | all safe product events | later source rewrite task | planned |
| F-010 | Paywall/entitlement baseline | user | paywall | Manager/Service when purchase state appears | paywall | entitlement controller | mock purchase service | entitlement state | paywall_shown, entitlement_changed | later source rewrite task | planned |

## 5. Update Rules

Update this file when:

- A new first-phase feature is added or removed.
- A task changes routes, state, services, data, entitlements, events, or tests.
- A feature moves between statuses.
- A feature is intentionally deferred.

Do not mark a feature `implemented` without source files and updated indexes.
Do not mark a feature `verified` without test or verification evidence in
`TEST_VERIFICATION_MATRIX.md`.
