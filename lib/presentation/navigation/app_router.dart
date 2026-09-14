import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/presentation/navigation/app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: UiKitRoute.page, initial: true),
        AutoRoute(page: ExampleRoute.page),
      ];
}
