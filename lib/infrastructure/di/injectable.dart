import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/infrastructure/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
