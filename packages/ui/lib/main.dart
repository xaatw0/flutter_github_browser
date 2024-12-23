import 'package:flutter/material.dart';
import 'package:mvp_flutter/mvp_flutter.dart';
import 'package:ui/pages/search_repositories/search_repositories_page.dart';
import 'l10n-gen/l10n.dart';
import 'pages/search_repositories/search_repositories_presenter_interface.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    this.buildPresenter,
  });

  final SearchRepositoriesPresenterInterface Function(BaseView view)?
  buildPresenter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: SearchRepositoriesPage(
        buildPresenter: buildPresenter,
      ),
    );
  }
}