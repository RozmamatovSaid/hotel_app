import 'package:flutter/material.dart';
import 'package:hotel_app/core/providers/providers.dart';
import 'package:hotel_app/core/router/router.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: Providers.providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (_) => FadeForwardsPageTransitionsBuilder(),
          ),
        ),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRouter.appRoutes,
    );
  }
}
