import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/services/service_locator.dart';
import 'package:mvp_flutter/mvp_flutter.dart';
import 'package:ui/pages/search_repositories/search_repositories_model.dart';
import 'package:ui/pages/search_repositories/search_repositories_presenter_interface.dart';

class SearchRepositoriesPresenter
    implements SearchRepositoriesPresenterInterface {
  final BaseView _view;

  SearchRepositoriesPresenter(this._view);

  SearchRepositoriesModel get _model => _delegate.model;

  final _delegate = PresenterDelegate(
    SearchRepositoriesModel.init(
        ServiceLocator.singleton().repositorySearchRepository),
  );

  @override
  List<GitRepositoryEntity> get entities => _model.entities;

  @override
  bool get isLoading => _model.status.isLoading;

  @override
  bool get canInput => _model.status.canInput;

  @override
  bool get canTapSearch => _model.status.canTapSearch;

  @override
  void reset() {
    _delegate.refresh(_view, _model.reset());
  }

  @override
  Future<void> searchRepositories() async {
    final statusLoading = _model.startSearch();
    _delegate.refresh(_view, statusLoading);

    try {
      final newEntities = await statusLoading.searchRepositories();
      final statusAfterLoading = _model.finishSearch(newEntities);
      _delegate.refresh(_view, statusAfterLoading);
    } catch (ex) {
      _delegate.refresh(_view, _model.finishSearch([]));
      rethrow;
    }
  }

  @override
  void changeKeyword(String keyword) {
    final statusWithNewKeyword = _model.changeKeyword(keyword);
    _delegate.refresh(
      _view,
      statusWithNewKeyword,
      updateWhen: (model) => model.status.canTapSearch,
    );
  }
}
