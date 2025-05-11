import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/features/done/ui/done_screen.dart';
import 'package:sayeercoop/features/landing/ui/landing_screen.dart';
import 'package:sayeercoop/features/register/ui/register_screen.dart';

/// Class to handle routing in the app using GoRouter for web URL support
class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.landingScreen,
    routes: [
      GoRoute(
        path: Routes.landingScreen,
        name: 'landing',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: Routes.registerScreen,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.doneScreen,
        name: 'done',
        builder: (context, state) => const DoneScreen(),
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('404 - Page not found'))),
  );
}
