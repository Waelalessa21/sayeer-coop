import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sayeercoop/common/routing/app_router.dart';
import 'package:sayeercoop/sayeer_coop_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(SayeerCoopApp(appRouter: AppRouter()));
}
