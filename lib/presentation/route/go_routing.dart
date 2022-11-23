import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/presentation/route/route_config.dart';

class Routing {
  Routing();

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  late GoRouter router;

// создаем роуты приложения
  GoRouter initRouter([String? initPath]) {
    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
              path: '/',
              pageBuilder: (context, state) => RoutePageConfig.homePage(),
              routes: [
                GoRoute(
                  path: 'details',
                  pageBuilder: (context, state) => RoutePageConfig.detailPage(),
                ),
              ]),
          GoRoute(
              path: '/city',
              pageBuilder: (context, state) =>
                  RoutePageConfig.chooseSityPage()),
        ],
        initialLocation: initPath);
    return router;
  }
}

class GoRouterBackButtonDispatcher extends BackButtonDispatcher {}
