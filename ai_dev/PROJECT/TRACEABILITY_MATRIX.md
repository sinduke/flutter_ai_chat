# Traceability Matrix

## 1. Purpose

This file connects source-history evidence, product goals, Flutter features,
data contracts, state, observability, tests, and task files.

It is especially important because this project intentionally rewrites another
app while preserving architecture evolution.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deferred`

## 3. Traceability Rows

| Product / Rewrite Goal | Source Evidence | Flutter Feature | Routes | Functions / Services | Data Contracts | State / Permission | Observability | Tests | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Establish Flutter app foundation | Flutter project + AIChats template stage | F-001 | ROUTE-APP-001 | FN-APP-001, FN-ROUTE-001 | DTO-APP-001 | app boot state | app_started | app boot/theme tests | planned |
| Map AIChats commit history into rewrite tasks | AIChats git log | F-002 | none | source-history workflow | source commit map task data | none | source_step_mapped | review evidence | planned |
| Build static tab shell | AIChats app shell/tab stages | F-003 | ROUTE-TAB-001..004 | router/tab controller | tab config | tab state | tab_selected | widget test | planned |
| Build onboarding baseline | AIChats onboarding commits | F-004 | welcome/onboarding | onboarding controller | onboarding state | onboarding state | onboarding_started/completed | controller/widget tests | planned |
| Build explore/avatar discovery | AIChats explore/avatar commits | F-005 | explore/category | avatar service | DTO-AVATAR-001 | none initially | avatar_viewed/selected | controller/widget tests | planned |
| Build chats list | AIChats chats commits | F-006 | chats | chat service | DTO-CHAT-001 | none initially | chat_opened | controller/widget tests | planned |
| Build chat conversation | AIChats chat commits | F-007 | chat detail | FN-CHAT-001, FN-CHAT-002, FN-AI-001 | DTO-CHAT-001, DTO-CHAT-002, DTO-AI-* | chat generation state | message_sent, ai_reply_generated | controller/service/widget tests | planned |
| Add profile/settings | AIChats profile/settings commits | F-008 | profile/settings | auth/user mock services | user profile contract later | capability gates later | settings_action | controller/widget tests | planned |
| Add observability baseline | AIChats logging commits | F-009 | all screens | FN-ANALYTICS-001 | DTO-OBS-001 | sensitive-data policy | safe event logs | unit/review evidence | planned |
| Add paywall/entitlements | AIChats purchase commits | F-010 | paywall | purchase/entitlement service | entitlement state | entitlement state | paywall_shown | controller/widget tests | planned |

## 4. Update Rules

Update this file when:

- A source commit/range is selected for implementation.
- A task changes the rewrite route.
- A feature, state, DTO, function, route, permission, or test contract changes.
- A source-history step is deferred or intentionally skipped.
