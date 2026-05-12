import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ai_chat/core/app_page/app_page_shell_storage.dart';
import 'package:flutter_ai_chat/core/tabbar_page/tabbar_page.dart';
import 'package:flutter_ai_chat/main.dart';

void main() {
  testWidgets('AppPage switches from onboarding to tabbar on tap', (
    WidgetTester tester,
  ) async {
    final storage = _FakeAppPageShellStorage(showTabBar: false);

    await tester.pumpWidget(MyApp(appPageShellStorage: storage));

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Explore'), findsNothing);

    await tester.tap(find.text('Onboarding'));
    await tester.pump(const Duration(milliseconds: 175));

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
    expect(
      tester.getCenter(find.text('Onboarding')).dx,
      lessThan(
        tester.getCenter(find.byKey(const ValueKey('explore-page-title'))).dx,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsNothing);
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
    expect(storage.showTabBar, isTrue);

    await tester.tap(find.byKey(const ValueKey('explore-page-title')));
    await tester.pump(const Duration(milliseconds: 175));

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
    expect(
      tester.getCenter(find.text('Onboarding')).dx,
      lessThan(
        tester.getCenter(find.byKey(const ValueKey('explore-page-title'))).dx,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.byKey(const ValueKey('explore-page-title')), findsNothing);
    expect(storage.showTabBar, isFalse);
  });

  testWidgets('AppPage restores persisted tabbar state', (
    WidgetTester tester,
  ) async {
    final storage = _FakeAppPageShellStorage(showTabBar: false);

    await tester.pumpWidget(MyApp(appPageShellStorage: storage));
    await tester.tap(find.text('Onboarding'));
    await tester.pumpAndSettle();

    expect(storage.showTabBar, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(MyApp(appPageShellStorage: storage));
    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsNothing);
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
  });

  testWidgets('TabbarPage renders three static items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CupertinoApp(home: TabbarPage()));

    expect(find.text('Explore'), findsWidgets);
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.text('Chats'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('chats-page-title')), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('profile-page-title')), findsOneWidget);
  });
}

final class _FakeAppPageShellStorage implements AppPageShellStorage {
  _FakeAppPageShellStorage({required this.showTabBar});

  bool showTabBar;

  @override
  Future<bool> loadShowTabBar() async {
    return showTabBar;
  }

  @override
  Future<void> saveShowTabBar(bool showTabBar) async {
    this.showTabBar = showTabBar;
  }
}
