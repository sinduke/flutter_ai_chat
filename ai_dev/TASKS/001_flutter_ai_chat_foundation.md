# 001 Flutter AI Chat Foundation

Status: proposed

## Goal

Create the first approved Flutter AI Chat foundation task from the active
`flutter-ai-chat` preset.

This task should replace the starter counter app with a real Flutter app shell
only after the user approves Build mode.

## Non-Goals

- Do not rebuild the full current AIChats `main` branch in one task.
- Do not choose a final remote AI provider.
- Do not add provider credentials or API keys.
- Do not implement purchases, push, deep links, or remote analytics yet.
- Do not rewrite unrelated platform assets or existing user changes.

## Implementation Steps

| Step | Status | Description | Expected Evidence |
| --- | --- | --- | --- |
| S1 | pending | Confirm source-history starting point from the AIChats repository. | Source branch and commit/range recorded. |
| S2 | pending | Replace counter demo with a Flutter app shell using existing design tokens. | `lib/main.dart` or app shell files updated. |
| S3 | pending | Add placeholder routes/tabs for Welcome, Explore, Chats, and Profile when approved. | App renders the intended first shell. |
| S4 | pending | Add focused smoke/widget tests if source files change. | `flutter test` passes. |
| S5 | pending | Update project indexes for every source file and contract change. | Project maps reference changed files and features. |

## Index Updates

Expected indexes to update during Build:

- `ai_dev/PROJECT/FEATURE_MAP.md`
- `ai_dev/PROJECT/FILE_MAP.md`
- `ai_dev/PROJECT/IMPLEMENTATION_MAP.md`
- `ai_dev/PROJECT/API_ROUTE_MAP.md`
- `ai_dev/PROJECT/FUNCTION_SIGNATURE_INDEX.md`
- `ai_dev/PROJECT/DTO_CONTRACT_INDEX.md`
- `ai_dev/PROJECT/STATE_MACHINE_INDEX.md`
- `ai_dev/PROJECT/TEST_VERIFICATION_MATRIX.md`
- `ai_dev/PROJECT/TRACEABILITY_MATRIX.md`
- `ai_dev/PROJECT/DECISION_LOG.md` if package or architecture choices are made.
- `ai_dev/PROJECT/RISK_REGISTER.md` if source-history or tooling risks change.

## Verification Gates

Before marking this task complete, run or explicitly justify skipping:

```text
./ai_dev/bin/aidev check
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
git diff --check
```

