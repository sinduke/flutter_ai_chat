# Data Contract Index

## 1. Purpose

This file defines stable data contracts used by Flutter UI, controllers,
services, mock data, and future remote APIs.

Do not use provider-specific response shapes directly in widgets.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deprecated`

## 3. Data Contract Template

```text
Data ID:
Name:
Used By:
Fields:
Sensitive Fields:
Validation:
Default / Empty State:
Status:
```

## 4. Planned Data Contracts

### `AppEnvironment`

Data ID: DTO-APP-001

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `mode` | enum | yes | `mock` | no | mock/dev/prod. |
| `appVersion` | String? | no | platform value | no | Optional diagnostics context. |

Status: planned

### `AvatarSummary`

Data ID: DTO-AVATAR-001

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `id` | String | yes | none | no | Stable avatar/character ID. |
| `name` | String | yes | none | no | Display name. |
| `subtitle` | String? | no | none | no | Short description. |
| `imageUrl` | String? | no | none | no | Remote/local image reference. |
| `category` | String? | no | none | no | Explore grouping. |

Status: planned

### `ChatSession`

Data ID: DTO-CHAT-001

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `id` | String | yes | none | no | Stable chat session ID. |
| `avatarId` | String? | no | none | no | Character/avatar reference. |
| `title` | String | yes | generated | no | List/detail display title. |
| `messages` | List<ChatMessage> | yes | [] | may contain sensitive content | Do not log raw content by default. |
| `updatedAt` | DateTime? | no | none | no | Sorting. |

Status: planned

### `ChatMessage`

Data ID: DTO-CHAT-002

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `id` | String | yes | none | no | Stable message ID. |
| `sessionId` | String | yes | none | no | Owning chat session. |
| `author` | enum | yes | none | no | user/assistant/system. |
| `content` | String | yes | empty | yes | Do not log by default. |
| `createdAt` | DateTime? | no | none | no | Message order. |
| `status` | enum | yes | `sent` | no | sending/sent/streaming/failed. |

Status: planned

### `ChatGenerationRequest`

Data ID: DTO-AI-001

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `sessionId` | String | yes | none | no | Chat context. |
| `avatarId` | String? | no | none | no | Character context. |
| `messages` | List<ChatMessage> | yes | [] | yes | Avoid logging raw content. |

Status: planned

### `ChatGenerationResult`

Data ID: DTO-AI-002

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `message` | ChatMessage | yes | none | may contain sensitive content | Assistant reply. |
| `providerTraceId` | String? | no | none | no | Safe diagnostic ID only. |

Status: planned

### `AppEvent`

Data ID: DTO-OBS-001

| Field | Type | Required | Default | Sensitive | Notes |
| --- | --- | --- | --- | --- | --- |
| `name` | String | yes | none | no | Stable event name. |
| `parameters` | Map<String, Object?> | no | {} | maybe | Must be redacted. |
| `timestamp` | DateTime? | no | now | no | Optional. |

Status: planned
