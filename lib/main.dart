import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tree_view_challenge/core/di/get_it.dart';
import 'package:tree_view_challenge/core/theme/theme.dart';
import 'package:tree_view_challenge/feature/asset/presentation/page/asset_page.dart';

import 'feature/home/presentation/page/home_page.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: _router,
      //routerDelegate: _router.routerDelegate,
      //routeInformationParser: _router.routeInformationParser,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (_, __) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: Routes.asset,
      path: '${Routes.asset}/:${PathParams.companyId}',
      builder: (_, GoRouterState state) {
        final companyId = state.pathParameters[PathParams.companyId];
        return AssetPage(companyId: companyId!);
      },
    ),
  ],
);

class Routes {
  static const String home = '/';
  static const String asset = '/asset';
}

class PathParams {
  static const String companyId = 'companyId';
}