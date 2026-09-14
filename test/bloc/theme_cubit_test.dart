import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_agents/presentation/state_management/theme/theme_cubit.dart';
import 'package:flutter_agents/presentation/state_management/theme/theme_state.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  setUp(() {
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  group('ThemeCubit', () {
    test('initial state has AppThemeMode.system', () {
      expect(ThemeCubit().state.themeMode, AppThemeMode.system);
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits updated themeMode when setThemeMode is called',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.setThemeMode(AppThemeMode.dark),
      expect: () => const [ThemeState(themeMode: AppThemeMode.dark)],
    );

    blocTest<ThemeCubit, ThemeState>(
      'toggles theme between light and dark',
      build: () => ThemeCubit(),
      act: (cubit) {
        cubit.setThemeMode(AppThemeMode.light);
        cubit.toggleTheme();
      },
      expect: () => const [
        ThemeState(themeMode: AppThemeMode.light),
        ThemeState(themeMode: AppThemeMode.dark),
      ],
    );
  });
}
