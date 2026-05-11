# Route Map

## 1. Purpose

This file maps Flutter navigation routes and external API/service surfaces for
the current project.

Flutter UI routes are listed here even before a backend API exists. External
network APIs should be added only when a task introduces a remote service.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deferred`
- `superseded`

## 3. Route Contract Template

```text
Route ID:
Type: ui_route | service_api | platform_channel | deep_link
Path / Name:
Auth / Entitlement:
Input:
Output:
Handler / Controller:
Feature ID:
Status:
Notes:
```

## 4. Planned Flutter UI Routes

| Route ID | Type | Path / Name | Auth / Entitlement | Input | Output | Handler / Controller | Feature | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ROUTE-APP-001 | ui_route | `/` | none | none | app shell | app router | F-001 | planned |
| ROUTE-TAB-001 | ui_route | `/welcome` | none | none | WelcomePage | onboarding | F-004 | planned |
| ROUTE-TAB-002 | ui_route | `/explore` | none | none | ExplorePage | explore | F-005 | planned |
| ROUTE-TAB-003 | ui_route | `/chats` | none | none | ChatsPage | chats | F-006 | planned |
| ROUTE-CHAT-001 | ui_route | `/chat/:id` | optional entitlement later | chatId | ChatPage | chat | F-007 | planned |
| ROUTE-TAB-004 | ui_route | `/profile` | optional auth later | none | ProfilePage | profile | F-008 | planned |
| ROUTE-SETTINGS-001 | ui_route | `/settings` | optional auth later | none | SettingsPage | settings | F-008 | planned |
| ROUTE-PAYWALL-001 | ui_route | `/paywall` | none | trigger context | PaywallPage | paywall | F-010 | planned |

## 5. External APIs

No remote API is contracted yet.

When remote AI, auth, avatar, chat, analytics, purchase, push, or experiment
services are introduced, add service/API rows here and link them to
`FUNCTION_SIGNATURE_INDEX.md` and `DTO_CONTRACT_INDEX.md`.

## 6. Deep Links

No deep links are contracted yet.

Add deep link routes when the source-history rewrite reaches the deep-link
feature stage or a Flutter task explicitly introduces them.
