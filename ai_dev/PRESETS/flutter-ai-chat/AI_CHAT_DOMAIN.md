# AI Chat Domain Rules

## 1. Purpose

This document defines reusable AI chat product concepts and boundaries.

It is not tied to one AI provider, backend, or source app.

## 2. Core Domain Concepts

Common domain models:

- `User`
- `Avatar` or `Character`
- `ChatSession`
- `ChatMessage`
- `MessageContent`
- `MessageAuthor`
- `ChatGenerationRequest`
- `ChatGenerationResult`
- `Attachment`
- `Entitlement`
- `ExperimentVariant`

Project-specific fields belong in the project DTO/data contract index.

## 3. Chat Session Rules

A chat session should have stable identity and clear ownership.

Track at least:

- Session ID.
- Avatar or character ID when applicable.
- Participant/user identity when available.
- Message list or message stream.
- Creation and update timestamps.
- Read state when the UI depends on it.
- Deletion/report state when moderation exists.

UI-only list grouping, date labels, and animation flags should not be persisted
as core session truth unless the project explicitly decides otherwise.

## 4. Message Rules

Messages should distinguish:

- User messages.
- Assistant/AI messages.
- System/status messages.
- Error or retryable failed messages.

Message content should be modeled so future text, image, attachment, and
streaming states can evolve without rewriting the entire chat UI.

## 5. AI Provider Boundary

The AI provider must sit behind an application/data boundary.

Recommended protocol shape:

```text
AIChatService
  generateReply(request) -> ChatGenerationResult
  streamReply(request) -> Stream<ChatGenerationDelta>
```

Do not call OpenAI, Firebase Functions, or another provider directly from a
Flutter page or widget.

## 6. Mock-First Development

Every external AI, auth, avatar, chat, analytics, purchase, push, or experiment
service should have a mock/fake implementation before the remote implementation
is required by a task.

Mocks should be:

- Deterministic by default.
- Able to simulate loading, failure, empty, and success states.
- Safe for widget tests.
- Free of network and credentials.

## 7. Streaming and Typing UX

If streaming is implemented:

- Keep provider deltas separate from rendered text state.
- Avoid rebuilding the whole chat page for every token when batching is safer.
- Preserve cancellation and retry behavior.
- Test partial, completed, failed, and cancelled streams.

If non-streaming is used first, keep the service contract able to evolve toward
streaming later.

## 8. Safety and Moderation

AI chat apps should document:

- Message report flow.
- Delete conversation flow.
- User block/mute behavior if supported.
- Error handling for blocked content or provider refusal.
- Data retention assumptions.

Do not expose provider error details directly to users unless they are safe and
actionable.

## 9. Monetization Boundary

Paywall and entitlement logic must stay outside chat rendering widgets.

Chat UI may ask whether a capability is available, but purchase provider logic
belongs behind a purchase/entitlement service.

## 10. Analytics Boundary

Track product events through an analytics abstraction.

Useful event categories:

- screen viewed.
- chat opened.
- message sent.
- AI reply requested.
- AI reply succeeded/failed.
- avatar selected.
- paywall shown.
- entitlement changed.
- settings action.

Do not couple feature widgets to concrete analytics SDKs.

