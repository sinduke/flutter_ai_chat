# Traceability Matrix

## 1. Purpose

This file connects source-history evidence, product goals, architecture stages,
Flutter features, data contracts, state, observability, tests, and task files.

It is especially important because this project intentionally rewrites another
app while preserving architecture evolution.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deferred`

## 3. Traceability Rows

| Product / Rewrite Goal | Source Evidence | Architecture Stage | Flutter Feature | Routes | Functions / Services | Data Contracts | State / Permission | Observability | Tests | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Establish Flutter app foundation | Flutter project + AIChats template stage | starter -> view-first | F-001 | ROUTE-APP-001 | FN-APP-002, FN-APP-003 | local preference key `app_page.show_tab_bar` | app boot state, persisted page-controlled AppPage shell preview state | none yet | TEST-APP-001, TEST-APP-002 | implemented |
| Map AIChats commit history into rewrite tasks | AIChats git log | documentation/control plane | F-002 | none | source-history workflow | source commit map task data | none | source_step_mapped | review evidence | planned |
| Build static tab shell | AIChats app shell/tab stages | view-first | F-003 | ROUTE-TAB-002..004 | no public function/service yet | static tab config | local Cupertino tab state, route-depth tabbar visibility | none yet | TEST-APP-003, TEST-APP-005 | implemented |
| Build onboarding baseline | AIChats onboarding commits | view-first | F-004 | ROUTE-TAB-001, ROUTE-ONBOARDING-001 | no public function/service yet | shared primary action button | Welcome onboarding flow | none yet | TEST-APP-004 | implemented |
| Build explore/avatar discovery | AIChats explore/avatar commits | view-first -> Service when mock/remote split appears | F-005 | explore/category | avatar service when justified | DTO-AVATAR-001 | none initially | avatar_viewed/selected | controller/widget tests | planned |
| Build chats list | AIChats chats commits | view-first -> Service when sessions are shared | F-006 | chats | chat service when justified | DTO-CHAT-001 | none initially | chat_opened | controller/widget tests | planned |
| Build chat conversation | AIChats chat commits | MVVM/controller -> Service when generation appears | F-007 | chat detail | FN-CHAT-001, FN-CHAT-002, FN-AI-001 | DTO-CHAT-001, DTO-CHAT-002, DTO-AI-* | chat generation state | message_sent, ai_reply_generated | controller/service/widget tests | planned |
| Add profile/settings | AIChats profile/settings commits | view-first -> Manager when shared account actions grow | F-008 | ROUTE-TAB-004, ROUTE-SETTINGS-001 | no public function/service yet | shared primary action button | profile/settings logout flow, route-depth tabbar visibility, temporary shell preference reset | none yet | TEST-APP-005 | implemented |
| Add observability baseline | AIChats logging commits | Service boundary when events repeat | F-009 | all screens | FN-ANALYTICS-001 | DTO-OBS-001 | sensitive-data policy | safe event logs | unit/review evidence | planned |
| Add paywall/entitlements | AIChats purchase commits | Manager/Service when purchase state appears | F-010 | paywall | purchase/entitlement service | entitlement state | entitlement state | paywall_shown | controller/widget tests | planned |

## 4. Update Rules

Update this file when:

- A source commit/range is selected for implementation.
- A task changes the rewrite route.
- A feature, state, DTO, function, route, permission, or test contract changes.
- A source-history step is deferred or intentionally skipped.
