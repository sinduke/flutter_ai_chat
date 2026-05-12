import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ai_chat/core/app_page/app_page_shell_storage.dart';
import 'package:flutter_ai_chat/core/tabbar_page/tabbar_page.dart';
import 'package:flutter_ai_chat/core/welcome_page/welcome_page.dart';
import 'package:flutter_ai_chat/main.dart';

void main() {
  testWidgets('AppPage ignores page taps and switches after onboarding exit', (
    WidgetTester tester,
  ) async {
    final storage = _FakeAppPageShellStorage(showTabBar: false);

    await tester.pumpWidget(MyApp(appPageShellStorage: storage));

    expect(find.byKey(const ValueKey('welcome-page-title')), findsOneWidget);
    expect(find.text('Explore'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('welcome-page-title')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('welcome-page-title')), findsOneWidget);
    expect(find.byKey(const ValueKey('explore-page-title')), findsNothing);
    expect(storage.showTabBar, isFalse);

    await tester.tap(
      find.byKey(const ValueKey('welcome-page-get-started-button')),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('onboard-completed-page-title')),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(const ValueKey('onboard-completed-page-completed-button')),
    );
    await tester.pump(const Duration(milliseconds: 175));

    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('onboard-completed-page-title')),
      findsOneWidget,
    );
    expect(
      tester
          .getCenter(find.byKey(const ValueKey('onboard-completed-page-title')))
          .dx,
      lessThan(
        tester.getCenter(find.byKey(const ValueKey('explore-page-title'))).dx,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('welcome-page-title')), findsNothing);
    expect(
      find.byKey(const ValueKey('onboard-completed-page-title')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
    expect(storage.showTabBar, isTrue);
  });

  testWidgets('AppPage restores persisted tabbar state', (
    WidgetTester tester,
  ) async {
    final storage = _FakeAppPageShellStorage(showTabBar: false);

    await tester.pumpWidget(MyApp(appPageShellStorage: storage));
    await tester.tap(
      find.byKey(const ValueKey('welcome-page-get-started-button')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('onboard-completed-page-completed-button')),
    );
    await tester.pumpAndSettle();

    expect(storage.showTabBar, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(MyApp(appPageShellStorage: storage));
    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsNothing);
    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);
  });

  testWidgets('Settings logout returns AppPage to onboarding', (
    WidgetTester tester,
  ) async {
    final storage = _FakeAppPageShellStorage(showTabBar: true);

    await tester.pumpWidget(MyApp(appPageShellStorage: storage));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('explore-page-title')), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Explore'), findsWidgets);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.byKey(const ValueKey('tabbar-page-tabbar-opacity')),
          )
          .opacity,
      1,
    );

    await tester.tap(
      find.byKey(const ValueKey('profile-page-settings-button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('settings-page-title')), findsOneWidget);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.byKey(const ValueKey('tabbar-page-tabbar-opacity')),
          )
          .opacity,
      0,
    );

    await tester.tap(find.byKey(const ValueKey('settings-page-logout-button')));
    await tester.pump();

    expect(find.text('Logging out...'), findsOneWidget);
    expect(storage.showTabBar, isTrue);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('welcome-page-title')), findsOneWidget);
    expect(find.byKey(const ValueKey('settings-page-title')), findsNothing);
    expect(storage.showTabBar, isFalse);
  });

  testWidgets('WelcomePage opens onboarding completed page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CupertinoApp(home: WelcomePage()));

    expect(find.byKey(const ValueKey('welcome-page-title')), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('welcome-page-get-started-button')),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('onboard-completed-page-title')),
      findsOneWidget,
    );
    expect(find.text('Completed'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('Completed')).style?.color,
      CupertinoColors.white,
    );

    await tester.tap(
      find.byKey(const ValueKey('onboard-completed-page-completed-button')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('welcome-page-title')), findsOneWidget);
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
