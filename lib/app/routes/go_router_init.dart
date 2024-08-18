import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_flutter/app/routes/routes.dart';
import 'package:news_flutter/presentation/views/error_screen.dart';
import 'package:news_flutter/presentation/views/news_screen.dart';

final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>();

GoRouter routerinit = GoRouter(
  initialLocation: AppRoutes.ROUTE_PATH_NEWS,
  navigatorKey: _navigatorState,
  routes: <RouteBase>[
    ///  =================================================================
    ///  ********************** Splash Route *****************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.ROUTE_NAME_NEWS,
      path: AppRoutes.ROUTE_PATH_NEWS,
      builder: (BuildContext context, GoRouterState state) {
        return const NewsScreen();
      },
    )
  ],
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: ErrorScreen());
  },
  redirect: (context, state) {
    print('redirect: ${state.uri}');
    return null;
  },
);
