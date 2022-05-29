import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:togg_case/const.dart';

import 'package:togg_case/screens/login.dart';

void main() {
  testWidgets('login page is created', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('login page contains login page text',
      (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('login page contains button', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    final buttonMaterial = find.descendant(
      of: find.byType(ElevatedButton),
      matching: find.byType(Material),
    );

    final materialButton = tester.widget<Material>(buttonMaterial);

    expect(materialButton.color, Colors.blue);
    expect(find.text(Const.login), findsOneWidget);
  });

  testWidgets('type into username textfield', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("username")), 'Test');

    await tester.pump();

    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('type into password textfield', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Login(),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("password")), 'Togg');

    await tester.pump();

    expect(find.text('Togg'), findsOneWidget);
  });
}
