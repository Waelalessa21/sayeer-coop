import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/routing/app_router.dart';

class SayeerCoopApp extends StatelessWidget {
  final AppRouter appRouter;

  const SayeerCoopApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Sayeer | ساير',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.black,
              onPrimary: Colors.white,
              secondary: Colors.grey,
              onSecondary: Colors.black,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            fontFamily: "IBMPlexSansArabic",
            scaffoldBackgroundColor: const Color(0xFFF2F9FE),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF2F9FE),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: AppRouter.router,
          builder: (context, child) {
            final Widget dirChild = Directionality(
              textDirection: TextDirection.rtl,
              child: child ?? const SizedBox(),
            );
            return MediaQuery(
              data: MediaQuery.of(context),
              child: Navigator(
                key: GlobalKey<NavigatorState>(),
                onGenerateRoute:
                    (settings) =>
                        MaterialPageRoute(builder: (context) => dirChild),
              ),
            );
          },
        );
      },
    );
  }
}
