import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_agents/l10n/generated/l10n.dart';
import 'package:flutter_agents/presentation/pages/uikit/uikit_page.dart';
import 'package:flutter_agents/presentation/state_management/theme/theme_cubit.dart';
import 'package:flutter_agents/presentation/theme/app_theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    final storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  testWidgets('UiKitPage renders showcase sections and toggles theme mode', (tester) async {
    final themeCubit = ThemeCubit();

    await tester.pumpWidget(
      BlocProvider<ThemeCubit>.value(
        value: themeCubit,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const UiKitPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(UiKitPage), findsOneWidget);
    expect(find.text('Buttons & Actions'), findsOneWidget);
    expect(find.text('Color Palette (#FFDE3F M3)'), findsOneWidget);
  });
}
