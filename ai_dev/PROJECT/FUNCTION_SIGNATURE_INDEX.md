# Function Signature Index

## 1. Purpose

This file tracks public use cases, controllers, repositories, and service
protocol functions for the Flutter AI Chat project.

It should be updated when a task introduces stable app-facing functions or
service contracts.

## 2. Status Values

- `planned`
- `contracted`
- `implemented`
- `verified`
- `deprecated`

## 3. Function Contract Template

```text
Function ID:
Feature:
Layer:
Name:
Signature:
Input Contract:
Output Contract:
Errors:
Owner Task:
Status:
```

## 4. Planned Function Contracts

| Function ID | Feature | Layer | Name | Draft Signature | Contract | Status |
| --- | --- | --- | --- | --- | --- | --- |
| FN-APP-001 | app_shell | app | `buildAppDependencies` | `AppDependencies buildAppDependencies(AppEnvironment env)` | AppDependencies | planned when DI stage is justified |
| FN-ROUTE-001 | app_shell | routing | `createAppRouter` | `AppRouter createAppRouter(AppDependencies dependencies)` | AppRouteConfig | planned when Router stage is justified |
| FN-CHAT-001 | chat | application | `loadChatSession` | `Future<ChatSession> loadChatSession(ChatSessionId id)` | ChatSession | planned |
| FN-CHAT-002 | chat | application | `sendMessage` | `Future<ChatMessage> sendMessage(SendMessageInput input)` | SendMessageInput, ChatMessage | planned |
| FN-AI-001 | chat | data/service | `generateReply` | `Future<ChatGenerationResult> generateReply(ChatGenerationRequest request)` | ChatGenerationRequest, ChatGenerationResult | planned |
| FN-AI-002 | chat | data/service | `streamReply` | `Stream<ChatGenerationDelta> streamReply(ChatGenerationRequest request)` | ChatGenerationRequest, ChatGenerationDelta | planned |
| FN-AVATAR-001 | avatar/explore | data/service | `fetchFeaturedAvatars` | `Future<List<AvatarSummary>> fetchFeaturedAvatars()` | AvatarSummary | planned |
| FN-ANALYTICS-001 | analytics | application/service | `trackEvent` | `Future<void> trackEvent(AppEvent event)` | AppEvent | planned |

## 5. Rules

- Domain/application contracts must not depend on `BuildContext`.
- Feature widgets must not call concrete remote provider SDKs directly.
- Mock service implementations must be available before remote service work is
  considered complete.
- Do not implement planned function contracts before the architecture stage needs
  them.
- When a function becomes implemented, add exact file paths to
  `FILE_MAP.md` and `IMPLEMENTATION_MAP.md`.
