# Risk Register

## 1. Purpose

This file tracks open risks, assumptions, blockers, and deferred decisions for
the Flutter AI Chat rewrite.

Update it when a task discovers uncertainty that could affect implementation,
verification, release safety, or architecture direction.

## 2. Status Values

- `open`
- `mitigated`
- `accepted`
- `closed`
- `superseded`

## 3. Risk Record Template

```text
### R-0000 Title

Status:
Type:
Severity:
Owner:

Context:

Impact:

Mitigation:

Trigger To Revisit:

References:
```

## 4. Current Risks

### R-0001 Source-history scope may be too large for one task

Status: open
Type: planning
Severity: medium
Owner: project

Context:

The AIChats source repository has many commits covering UI, services, logging,
experiments, purchases, routing, MVVM, and VIPER-style refactors.

Impact:

Trying to rewrite too much at once would hide architecture evolution and make
verification weak.

Mitigation:

Create a source-history map before implementation. Keep Build tasks small and
commit/range-bound.

Trigger To Revisit:

Before the first feature rewrite task.

References:

- `ai_dev/PRESETS/flutter-ai-chat/SOURCE_HISTORY_REWRITE.md`

### R-0002 State-management package is undecided

Status: open
Type: architecture
Severity: medium
Owner: project

Context:

The current Flutter app does not yet commit to Riverpod, Bloc, Provider,
ValueNotifier, or another state-management approach.

Impact:

Premature selection can cause unnecessary refactor or obscure the source
project's architecture evolution.

Mitigation:

Keep early code simple. Decide and record the package when a task needs durable
controller/view model and dependency injection structure.

Trigger To Revisit:

Before implementing app shell routing beyond placeholders or chat state.

References:

- `ai_dev/PRESETS/flutter-ai-chat/STATE_MANAGEMENT.md`
- `ai_dev/PROJECT/DECISION_LOG.md`

### R-0003 Remote AI provider shape is undecided

Status: open
Type: integration
Severity: high
Owner: project

Context:

The Flutter app may call a backend proxy, Firebase Functions, OpenAI directly
from a secure environment, or another provider path.

Impact:

Provider choice affects security, streaming, error mapping, logging, and test
strategy.

Mitigation:

Use mock-first AI service contracts. Do not commit provider keys. Decide remote
provider architecture in a dedicated task.

Trigger To Revisit:

Before implementing remote AI generation.

References:

- `ai_dev/PRESETS/flutter-ai-chat/AI_CHAT_DOMAIN.md`
- `ai_dev/PROJECT/CONFIG_ENV_INDEX.md`

### R-0004 Existing Flutter repo has pre-existing uncommitted platform changes

Status: open
Type: repository
Severity: medium
Owner: project

Context:

The working tree contains existing Flutter/iOS/Android/macOS asset and platform
configuration changes unrelated to the ai_dev preset setup.

Impact:

Future tasks could accidentally mix unrelated platform changes with ai_dev or
feature work.

Mitigation:

Keep write scopes explicit. Do not revert unrelated user changes. Stage only the
requested files for each task.

Trigger To Revisit:

Before committing or starting platform/build work.

References:

- `git status --short`

### R-0005 Temporary shell preference may conflict with final auth state

Status: open
Type: architecture
Severity: medium
Owner: app_shell

Context:

Task 001B persists `app_page.show_tab_bar` so the placeholder AppPage shell can
restore its last visible state. This is intentionally not the final auth,
session, or onboarding completion model.

Impact:

If future auth/onboarding work reads this temporary flag as a business source of
truth, a signed-out or expired-session user could be routed to the wrong shell.

Mitigation:

Keep the key documented as temporary shell preview state. Replace or migrate it
when real auth/session/onboarding state is implemented.

Trigger To Revisit:

Before implementing real onboarding completion, session restore, logout, or root
route decisions.

References:

- `ai_dev/TASKS/001B_app_page_shell_persistence.md`
- `ai_dev/PROJECT/DECISION_LOG.md`
