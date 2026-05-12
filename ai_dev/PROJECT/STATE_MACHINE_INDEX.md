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

This is a temporary shell state restored from `app_page.show_tab_bar`. The user
can no longer toggle it by tapping the whole AppPage; onboarding pages own the
transition into the tabbar shell.

```text
onboarding_preview
tabbar_preview
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `onboarding_preview` | `tabbar_preview` | AppPage restores persisted true value | `app_page.show_tab_bar == true` | show/animate tabbar preview | implemented |
| `onboarding_preview` | `tabbar_preview` | user exits OnboardCompletedPage | none | animate onboarding out left while tabbar enters from right; persist `app_page.show_tab_bar=true` | implemented |
| `tabbar_preview` | `onboarding_preview` | settings logout completes | none | animate tabbar out right while onboarding enters from left; persist `app_page.show_tab_bar=false` | implemented |

## 5. Welcome Onboarding Flow

```text
welcome
onboarding_completed
tabbar_preview
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `welcome` | `onboarding_completed` | user taps Get Started | none | push OnboardCompletedPage | implemented |
| `onboarding_completed` | `tabbar_preview` | user taps Completed | none | pop completion route; notify AppPage to persist and show tabbar shell | implemented |

## 6. TabbarPage Static Tab And Depth State

This is the current local placeholder tab state managed by a custom Cupertino
tab shell. Each tab keeps its own `CupertinoTabView` navigator, and the shell
hides the tabbar when the active tab route depth is greater than one.

```text
explore
chats
profile
tabbar_visible
tabbar_hidden
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `explore` | `chats` | user taps Chats tab | none | show Chats placeholder content | implemented |
| `explore`/`chats` | `profile` | user taps Profile tab | none | show Profile placeholder content | implemented |
| `chats`/`profile` | `explore` | user taps Explore tab | none | show Explore placeholder content | implemented |
| `tabbar_visible` | `tabbar_hidden` | active tab pushes a non-root route | route depth `> 1` | slide/fade tabbar out and remove bottom content padding | implemented |
| `tabbar_hidden` | `tabbar_visible` | active tab returns to root route | route depth `<= 1` | slide/fade tabbar in and restore bottom content padding | implemented |

## 7. Profile Settings Logout Flow

```text
profile
settings
logging_out
onboarding_preview
```

| From | To | Trigger | Guard | Side Effects | Status |
| --- | --- | --- | --- | --- | --- |
| `profile` | `settings` | user taps Profile nav Settings item | none | push SettingsPage in the profile tab navigator | implemented |
| `settings` | `logging_out` | user taps Logout | not already logging out | disable Logout button and wait 1 second | implemented |
| `logging_out` | `onboarding_preview` | logout delay completes | SettingsPage still mounted | notify AppPage; persist `app_page.show_tab_bar=false` | implemented |

## 8. Chat Generation State

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

## 9. Entitlement State

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
