import 'package:flutter/material.dart';
import 'package:hotel_app/mehmonxona_royhatlari/views/screens/mehmonxona_royhatlar_screen.dart';
import 'package:hotel_app/views/profile/screens/profile_screen.dart';

void main() => runApp(MyApp());

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
      home: MehmonxonaRoyhatlarScreen(),
    );
  }
}
