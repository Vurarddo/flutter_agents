import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agents/presentation/theme/app_theme.dart';
import 'package:flutter_agents/presentation/ui_kit/app_button.dart';

void main() {
  testWidgets('AppButton renders label and triggers onPressed', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: AppButton(
            label: 'Click Me',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);

    await tester.tap(find.text('Click Me'));
    await tester.pump();

    expect(pressed, isTrue);
  });
}
