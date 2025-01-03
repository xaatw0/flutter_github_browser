import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/repositories/repository_search_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/pages/search_repositories/search_repositories_model.dart';

import 'search_repositories_model_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RepositorySearchRepository>(),
])
main() {
  group('SearchRepositoriesStatus', () {
    test('isLoading', () {
      expect(SearchRepositoriesStatus.noKeyword.isLoading, false);
      expect(SearchRepositoriesStatus.inputtingKeyword.isLoading, false);
      expect(SearchRepositoriesStatus.searchingWithoutData.isLoading, true);
      expect(SearchRepositoriesStatus.showFoundData.isLoading, false);
      expect(SearchRepositoriesStatus.searchingWithData.isLoading, true);
    });

    test('canInput', () {
      expect(SearchRepositoriesStatus.noKeyword.canInput, true);
      expect(SearchRepositoriesStatus.inputtingKeyword.canInput, true);
      expect(SearchRepositoriesStatus.searchingWithoutData.canInput, false);
      expect(SearchRepositoriesStatus.showFoundData.canInput, false);
      expect(SearchRepositoriesStatus.searchingWithData.canInput, false);
    });

    test('canTapSearch', () {
      expect(SearchRepositoriesStatus.noKeyword.canTapSearch, false);
      expect(SearchRepositoriesStatus.inputtingKeyword.canTapSearch, true);
      expect(SearchRepositoriesStatus.searchingWithoutData.canTapSearch, false);
      expect(SearchRepositoriesStatus.showFoundData.canTapSearch, true);
      expect(SearchRepositoriesStatus.searchingWithData.canTapSearch, false);
    });
  });

  group('SearchRepositoriesModel', () {
    test('initialize', () {
      final model =
          SearchRepositoriesModel.init(MockRepositorySearchRepository());
      expect(model.status, SearchRepositoriesStatus.noKeyword);
      expect(model.keyword.isEmpty, true);
      expect(model.entities.isEmpty, true);
      expect(model.page, 0);
    });

    test('input keyword', () {
      final initModel =
          SearchRepositoriesModel.init(MockRepositorySearchRepository());
      final modelWithK = initModel.changeKeyword('k');
      expect(modelWithK.status, SearchRepositoriesStatus.inputtingKeyword);
      expect(modelWithK.keyword, 'k');
      expect(modelWithK.entities.isEmpty, true);
      expect(modelWithK.page, 0);

      final modelWithKeyword = initModel.changeKeyword('keyword');
      expect(
        modelWithKeyword.status,
        SearchRepositoriesStatus.inputtingKeyword,
      );
      expect(modelWithKeyword.keyword, 'keyword');
      expect(modelWithKeyword.entities.isEmpty, true);
      expect(modelWithKeyword.page, 0);

      final modelWithoutKeyword = initModel.changeKeyword('');
      expect(modelWithoutKeyword.keyword, '');
      expect(modelWithoutKeyword.entities.isEmpty, true);
      expect(modelWithoutKeyword.status, SearchRepositoriesStatus.noKeyword);
      expect(modelWithoutKeyword.page, 0);
    });

    test('state transition', () async {
      final repositorySearchRepository = MockRepositorySearchRepository();
      when(repositorySearchRepository.searchRepositories('keyword', 1))
          .thenAnswer((_) async => [
                GitRepositoryEntity(
                  authorName: 'authorName1',
                  repositoryName: 'repositoryName1',
                  description: 'description1',
                  authorImage: 'authorImage1',
                  stargazersCount: 11,
                  forksCount: 12,
                  issuesCount: 13,
                  watchersCount: 14,
                  lastUpdatedAt: DateTime(2025, 1, 1),
                ),
              ]);
      when(repositorySearchRepository.searchRepositories('keyword', 2))
          .thenAnswer((_) async => [
                for (var index = 2; index < 4; index++)
                  GitRepositoryEntity(
                    authorName: 'authorName$index',
                    repositoryName: 'repositoryName$index',
                    description: 'description$index',
                    authorImage: 'authorImage$index',
                    stargazersCount: 10 * index + 1,
                    forksCount: 10 * index + 2,
                    issuesCount: 10 * index + 3,
                    watchersCount: 10 * index + 4,
                    lastUpdatedAt: DateTime(2025, 1, index),
                  ),
              ]);
      final initModel =
          SearchRepositoriesModel.init(repositorySearchRepository);

      final modelWithKeyword = initModel.changeKeyword('keyword');
      final modelDuringSearching = modelWithKeyword.startSearch();
      expect(
        modelDuringSearching.status,
        SearchRepositoriesStatus.searchingWithoutData,
      );
      expect(modelDuringSearching.keyword, 'keyword');
      expect(modelDuringSearching.entities.isEmpty, true);
      expect(modelDuringSearching.page, 1);

      final newEntity = await modelDuringSearching.searchRepositories();
      expect(newEntity.length, 1);
      expect(newEntity[0].authorName, 'authorName1');

      final modelWithEntity = modelDuringSearching.finishSearch(newEntity);
      expect(modelWithEntity.status, SearchRepositoriesStatus.showFoundData);
      expect(modelWithEntity.keyword, 'keyword');
      expect(modelWithEntity.entities.length, 1);
      expect(modelWithEntity.page, 1);
      expect(modelWithEntity.entities[0].authorName, 'authorName1');

      final modelDuringSearchingWithData = modelWithEntity.startSearch();
      expect(modelDuringSearchingWithData.status,
          SearchRepositoriesStatus.searchingWithData);
      expect(modelDuringSearchingWithData.keyword, 'keyword');
      expect(modelDuringSearchingWithData.entities.length, 1);
      expect(modelDuringSearchingWithData.page, 2);

      final modelWith3Entities = modelDuringSearchingWithData.finishSearch(
          await modelDuringSearchingWithData.searchRepositories());
      expect(modelWith3Entities.status, SearchRepositoriesStatus.showFoundData);
      expect(modelWith3Entities.keyword, 'keyword');
      expect(modelWith3Entities.entities.length, 3);
      expect(modelWith3Entities.page, 2);

      expect(modelWith3Entities.entities[0].authorName, 'authorName1');
      expect(modelWith3Entities.entities[1].authorName, 'authorName2');
      expect(modelWith3Entities.entities[2].authorName, 'authorName3');

      final modelReset = modelWith3Entities.reset();
      expect(modelReset.status, SearchRepositoriesStatus.inputtingKeyword);
      expect(modelReset.keyword, 'keyword');
      expect(modelReset.entities.isEmpty, true);
      expect(modelReset.page, 0);
    });
  });
}
