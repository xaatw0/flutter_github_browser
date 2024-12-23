import 'package:domain/entities/git_repository_entity.dart';

abstract interface class SearchRepositoriesPresenterInterface {
  List<GitRepositoryEntity> get entities;

  bool get isLoading;

  bool get canInput;

  bool get canTapSearch;

  void reset();

  void changeKeyword(String keyword);

  Future<void> searchRepositories();
}
