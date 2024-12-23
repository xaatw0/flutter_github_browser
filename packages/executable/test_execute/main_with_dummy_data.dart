import 'package:domain/entities/git_repository_entity.dart';
import 'package:flutter/material.dart';
import 'package:ui/main.dart';
import 'package:ui/pages/search_repositories/search_repositories_presenter_interface.dart';

// cd .\packages\executable\
// fvm flutter run .\test_execute\main_with_dummy_data.dart
void main() {
  runApp(MainApp(
    buildPresenter: (view) => _PresenterWithDummyData(),
  ));
}

class _PresenterWithDummyData implements SearchRepositoriesPresenterInterface {
  @override
  bool get canInput => true;

  @override
  bool get canTapSearch => true;

  @override
  void changeKeyword(String keyword) {
    debugPrint('changeKeyword: $keyword');
  }

  @override
  List<GitRepositoryEntity> get entities => [
    for (int i = 0; i < 30; i++)
      GitRepositoryEntity(
        authorName: 'authorName$i',
        repositoryName: 'repositoryName$i',
        description: 'description$i',
        authorImage: 'https://placehold.jp/100x100.png?text=$i',
        stargazersCount: i * 10 + 1,
        forksCount: i * 10 + 2,
        issuesCount: i * 10 + 3,
        watchersCount: i * 10 + 4,
        lastUpdatedAt: DateTime(2024, 1, i + 1),
      )
  ];

  @override
  bool get isLoading => false;

  @override
  void reset() {}

  @override
  Future<void> searchRepositories() {
    debugPrint('searchRepositories');
    return Future.value();
  }
}
