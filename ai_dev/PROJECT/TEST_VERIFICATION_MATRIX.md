# Test Verification Matrix

## 1. Purpose

This file maps Flutter AI Chat features and contracts to required tests and
verification gates.

Passing a broad command is not enough when a feature changes routing, state,
chat generation, entitlements, logging, or platform configuration. The specific
risk path must be covered here.

## 2. Verification Status Values

- `planned`
- `required`
- `implemented`
- `passing`
- `skipped_with_reason`
- `blocked`

## 3. Command Baseline

Before Flutter source changes:

```text
./bin/aidev check
git diff --check
find ai_dev -name '.DS_Store' -print
rg -n "[ \t]+$" ai_dev || true
```

For normal Flutter source changes:

```text
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
git diff --check
```

For platform or asset changes:

```text
flutter analyze
flutter test
flutter build <target> --debug
```

The exact platform target should match the files changed.

## 4. Feature Verification Matrix

| Feature ID | Required Tests | Required Commands/Gates | Required Index Evidence | Status |
| --- | --- | --- | --- | --- |
| F-001 | app boots, AppPage placeholder toggle smoke test, widget preview annotations analyze cleanly | `flutter analyze`, `flutter test` | file/implementation/test indexes | passing |
| F-002 | source commit map reviewed against source repo | source `git log` evidence, `./bin/aidev check` | traceability, decision/risk updates | planned |
| F-003 | app shell renders tabs, tab selection state | widget test, `flutter test` | route/state/file indexes | planned |
| F-004 | onboarding loading/data/action states | controller test, widget test | feature/route/state indexes | planned |
| F-005 | explore empty/loading/data/error states | controller test, widget test | DTO/function/service indexes | planned |
| F-006 | chats list empty/data/open states | controller test, widget test | DTO/function/service indexes | planned |
| F-007 | send message success/failure, AI reply success/failure | controller/service tests, widget test | DTO/function/state indexes | planned |
| F-008 | profile/settings actions with mock services | controller/widget tests | permission/config/function indexes | planned |
| F-009 | safe analytics event emitted, no raw chat content logged | unit test or review evidence | observability/data index | planned |
| F-010 | entitlement gating and paywall action states | controller/widget tests | permission/state/function indexes | planned |

## 5. Test Record Template

```text
Test ID:
Feature ID:
Risk Covered:
Test File:
Command:
Expected Evidence:
Required Before:
Status:
Notes:
```

## 6. Current Test Records

```text
Test ID: TEST-APP-001
Feature ID: F-001
Risk Covered: AppPage boots into Onboarding and switches to Tabbar on tap with the expected directional slide transition.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "AppPage switches from onboarding to tabbar on tap" passes.
Required Before: considering the counter demo replaced by the view-first root shell.
Status: passing
Notes: Covers the current placeholder shell only; real auth, tab routes, and tab content remain later tasks. The widget test checks the mid-transition ordering for the horizontal slide effect. `flutter analyze` also validates the current shared preview annotations compile.
```

## 7. Critical Negative Tests

These negative paths are required before related features can be considered
verified:

- Empty message cannot be sent.
- Failed AI reply leaves retryable state when supported.
- Raw chat content is not logged by default.
- Paywalled action is blocked when entitlement is absent.
- Developer settings are not exposed in production unless explicitly allowed.
- Remote provider failure maps to a safe user-facing error.

## 8. Review Rules

For every Build task:

- Add or update rows for changed features.
- Mark skipped tests only with a reason and follow-up.
- Do not mark a feature verified unless the specific tests pass or the accepted
  verification evidence is recorded.
