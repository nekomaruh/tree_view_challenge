import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      //home: const HomePage(),
      initialRoute: '/',
      routes: {
        "/": (_) => const HomePage(),
        "/asset": (_) => const AssetPage(),
      },
    );
  }
}
