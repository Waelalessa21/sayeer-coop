import 'package:flutter/material.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/features/done/ui/done_screen.dart';
import 'package:sayeercoop/features/landing/ui/landing_screen.dart';
import 'package:sayeercoop/features/register/ui/register_screen.dart';

///Class to handle routing in the app.
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingScreen:
        return MaterialPageRoute(builder: (_) => const LandingScreen());

      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.doneScreen:
        return MaterialPageRoute(builder: (_) => const DoneScreen());
      default:
        return null;
    }
  }
}
