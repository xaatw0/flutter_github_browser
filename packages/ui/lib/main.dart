import 'package:flutter/material.dart';
import 'package:ui/pages/search_repositories/search_repositories_page.dart';
import 'l10n-gen/l10n.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: SearchRepositoriesPage(),
    );
  }
}
