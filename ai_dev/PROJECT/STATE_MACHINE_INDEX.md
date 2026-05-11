# State Machine Index

## 1. Purpose

This file records important app, onboarding, chat, generation, and entitlement
state machines.

Only durable or cross-feature states belong here. Pure animation flags and local
widget focus state do not need entries unless they affect behavior.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`

## 3. App Boot State

```text
not_started
bootstrapping
ready
failed
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `not_started` | `bootstrapping` | app launch | none | load dependencies/theme | planned |
| `bootstrapping` | `ready` | dependencies loaded | valid config | render app shell | planned |
| `bootstrapping` | `failed` | bootstrap error | unrecoverable config error | show safe error/log | planned |

## 4. AppPage Shell Preview State

This is a temporary local widget state for the first view-first shell. It is not
the final auth/session state machine.

```text
onboarding_preview
tabbar_preview
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `onboarding_preview` | `tabbar_preview` | user taps AppPage | none | animate onboarding out left while tabbar enters from right | implemented |
| `tabbar_preview` | `onboarding_preview` | user taps AppPage | none | animate tabbar out right while onboarding enters from left | implemented |

## 5. Chat Generation State

```text
idle
sending_user_message
waiting_for_ai
streaming_ai_reply
completed
failed
cancelled
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `idle` | `sending_user_message` | user sends text | input non-empty | append optimistic user message | planned |
| `sending_user_message` | `waiting_for_ai` | message saved | service available | request AI reply | planned |
| `waiting_for_ai` | `streaming_ai_reply` | first delta | streaming supported | append partial reply | planned |
| `waiting_for_ai` | `completed` | full reply | non-streaming success | append AI reply | planned |
| `streaming_ai_reply` | `completed` | stream complete | none | mark reply complete | planned |
| `sending_user_message`/`waiting_for_ai`/`streaming_ai_reply` | `failed` | service error | retryable/non-retryable mapped | show safe error | planned |
| `waiting_for_ai`/`streaming_ai_reply` | `cancelled` | user cancels | cancellable operation | stop provider request | planned |

## 6. Entitlement State

```text
unknown
free
trial
subscribed
expired
purchase_pending
purchase_failed
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `unknown` | `free`/`trial`/`subscribed`/`expired` | entitlement load | provider/mock result | update gates | planned |
| `free`/`trial`/`expired` | `purchase_pending` | purchase starts | provider available | show progress | planned |
| `purchase_pending` | `subscribed` | purchase success | receipt valid | unlock capability | planned |
| `purchase_pending` | `purchase_failed` | purchase error | safe error mapped | show recoverable error | planned |
