import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ai_chat/main.dart';

void main() {
  testWidgets('AppPage switches from onboarding to tabbar on tap', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Tabbar'), findsNothing);

    await tester.tap(find.text('Onboarding'));
    await tester.pump(const Duration(milliseconds: 175));

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Tabbar'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Onboarding')).dx,
      lessThan(tester.getCenter(find.text('Tabbar')).dx),
    );

    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsNothing);
    expect(find.text('Tabbar'), findsOneWidget);

    await tester.tap(find.text('Tabbar'));
    await tester.pump(const Duration(milliseconds: 175));

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Tabbar'), findsOneWidget);
    expect(
      tester.getCenter(find.text('Onboarding')).dx,
      lessThan(tester.getCenter(find.text('Tabbar')).dx),
    );

    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.text('Tabbar'), findsNothing);
  });
}
