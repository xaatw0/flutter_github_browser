import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:flutter/material.dart';
import 'package:mvp_flutter/mvp_flutter.dart';
import 'package:ui/l10n-gen/l10n.dart';
import 'package:ui/pages/search_repositories/search_repositories_presenter.dart';
import 'package:ui/widgets/molecules/loading_indicator.dart';

import '../../widgets/atoms/app_text_field.dart';
import 'search_repositories_presenter_interface.dart';

part 'search_repositories_page.repository_tile.dart';

class SearchRepositoriesPage extends StatefulWidget {
  const SearchRepositoriesPage({
    this.buildPresenter,
    super.key,
  });

  final SearchRepositoriesPresenterInterface Function(BaseView view)?
  buildPresenter;

  @override
  State<SearchRepositoriesPage> createState() => _SearchRepositoriesPageState();
}

class _SearchRepositoriesPageState extends State<SearchRepositoriesPage>
    implements BaseView {
  late final _presenter = buildPresenter();

  SearchRepositoriesPresenterInterface buildPresenter() =>
      widget.buildPresenter?.call(this) ?? SearchRepositoriesPresenter(this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.of(context).appTitle)),
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                spacing: 8.0,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                            isReadOnly: !_presenter.canInput,
                            hintText: L10n.of(context).searchHint,
                            onChanged: (String value) =>
                                _presenter.changeKeyword(value),
                            onSubmitted: _searchRepositories),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(scale: animation, child: child);
                        },
                        child: CircleAvatar(
                          radius: 32,
                          child: IconButton(
                              onPressed: _presenter.canTapSearch
                                  ? (_presenter.canInput
                                  ? _searchRepositories
                                  : _presenter.reset)
                                  : null,
                              icon: _presenter.isLoading
                                  ? const LoadingIndicator()
                                  : Icon(
                                _getIconData(_presenter.entities.isNotEmpty),
                                size: 32.0,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: NotificationListener(
                      onNotification: (ScrollEndNotification notification) {
                        final isScrollToEnd = notification.metrics.extentAfter == 0;

                        if (isScrollToEnd) {
                          _presenter.searchRepositories();
                        }
                        return false;
                      },
                      child: ListView.builder(
                          itemCount: _presenter.entities.length +
                              (_presenter.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_presenter.entities.length == index) {
                              return const LoadingIndicator();
                            }

                            return _RepositoryTile(
                                item: _presenter.entities[index]);
                          }),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  IconData _getIconData(bool hasData) {
    return hasData ? Icons.cancel : Icons.search;
  }

  void _searchRepositories() {
    _presenter
        .searchRepositories()
        .catchError(_showSnackBarWhenLoadingException);
  }

  void _showSnackBarWhenLoadingException(ex) {
    if (ex is! ExceptionsWhenLoadingRepositories) {
      throw ex;
    }

    final message = switch (ex) {
      NoHostException() => L10n.of(context).githubConnectionFailed,
      TooManyRequestsException() => L10n.of(context).searchLimitReached,
    };

    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(message));
  }

  SnackBar _buildSnackBar(String message) {
    return SnackBar(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      margin: const EdgeInsetsDirectional.all(8),
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          spacing: 16,
          children: [
            const Icon(Icons.warning, color: Colors.yellow),
            Flexible(child: Text(message)),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 8.0,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}