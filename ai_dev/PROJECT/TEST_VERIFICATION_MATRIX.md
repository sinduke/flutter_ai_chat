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
| F-001 | app boots, AppPage ignores whole-page taps, page-controlled onboarding exit switches to tabbar, persisted shell restore test, widget preview annotations analyze cleanly | `flutter analyze`, `flutter test` | file/implementation/test indexes | passing |
| F-002 | source commit map reviewed against source repo | source `git log` evidence, `./bin/aidev check` | traceability, decision/risk updates | planned |
| F-003 | app shell renders Explore/Chats/Profile tabs, tab selection state, route-depth tabbar hiding | widget test, `flutter test` | route/state/file indexes | passing |
| F-004 | WelcomePage opens completed page, Completed action returns to AppPage tabbar shell with readable primary button text | widget test, `flutter test` | feature/route/state indexes | passing |
| F-005 | explore empty/loading/data/error states | controller test, widget test | DTO/function/service indexes | planned |
| F-006 | chats list empty/data/open states | controller test, widget test | DTO/function/service indexes | planned |
| F-007 | send message success/failure, AI reply success/failure | controller/service tests, widget test | DTO/function/state indexes | planned |
| F-008 | profile opens Settings, Settings hides tabbar, logout waits and returns AppPage to onboarding | widget test, `flutter test` | route/state/file indexes | passing |
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
Risk Covered: AppPage boots into Welcome, ignores whole-page taps, and switches to Tabbar only after the onboarding completion exit action.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "AppPage ignores page taps and switches after onboarding exit" passes.
Required Before: considering the counter demo replaced by the view-first root shell.
Status: passing
Notes: Covers the current shell only; real auth, tab routes, and tab content remain later tasks. The widget test confirms AppPage no longer toggles from arbitrary taps, checks the AppPageBuilder mid-transition ordering for the horizontal slide effect, and verifies writes to the temporary shell storage. `flutter analyze` also validates the current shared preview annotations compile.
```

```text
Test ID: TEST-APP-002
Feature ID: F-001
Risk Covered: AppPage restores the persisted tabbar shell state after the widget tree is rebuilt.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "AppPage restores persisted tabbar state" passes.
Required Before: treating the current AppPage shell preference as AppStorage-like local state.
Status: passing
Notes: Uses a fake AppPageShellStorage to validate the AppPage contract without depending on platform SharedPreferences in widget tests.
```

```text
Test ID: TEST-APP-003
Feature ID: F-003
Risk Covered: TabbarPage exposes the three static tab items, switches between the placeholder Explore, Chats, and Profile pages, and hides the tabbar when the active tab pushes a second-level route.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "TabbarPage renders three static items" passes.
Required Before: treating the current tab shell as the implemented static tabbar baseline.
Status: passing
Notes: Covers the placeholder Explore, Chats, and Profile pages plus the current route-depth driven tabbar hide/show behavior. Real feature content, routes, analytics, and auth/profile behavior remain later tasks.
```

```text
Test ID: TEST-APP-004
Feature ID: F-004
Risk Covered: WelcomePage navigates to OnboardCompletedPage, and the Completed action can return control to the app shell with readable primary button text.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "WelcomePage opens onboarding completed page" passes.
Required Before: treating WelcomePage and OnboardCompletedPage as the implemented onboarding baseline.
Status: passing
Notes: Covers the placeholder onboarding flow only. Also verifies the shared primary action button renders white text on the red background. Final onboarding persistence, auth/session logic, analytics, and profile initialization remain later tasks.
```

```text
Test ID: TEST-APP-005
Feature ID: F-008
Risk Covered: Profile exposes a top-right Settings nav item, Settings hides the tabbar as a second-level route, logout waits before returning the root shell to onboarding, and the temporary shell preference is reset.
Test File: test/widget_test.dart
Command: flutter test
Expected Evidence: "Settings logout returns AppPage to onboarding" passes.
Required Before: treating the view-first profile/settings logout baseline as implemented.
Status: passing
Notes: Covers only the placeholder logout shell transition. Real auth/session invalidation, network calls, analytics, and user profile clearing remain later tasks.
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
