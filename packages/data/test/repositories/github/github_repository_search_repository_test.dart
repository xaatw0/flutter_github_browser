import 'dart:io';

import 'package:data/repositories/github/github_repository_search_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:domain/services/http_service.dart';
import 'package:domain/services/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'github_repository_search_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpService>(),
  MockSpec<ServiceLocator>(),
])
main() {
  final testJson =
  File('test/services/github/github_repository_search_service_test.json');

  final mockHttpService = MockHttpService();
  final mockServiceLocator = MockServiceLocator();
  when(mockServiceLocator.httpService).thenReturn(mockHttpService);

  ServiceLocator.init(
    mockHttpService,
    GithubRepositorySearchRepository(),
  );

  test('searchRepositories', () async {
    when(mockHttpService.get(
      'https://api.github.com/search/repositories',
      queryParameters: {'q': 'flutter', 'page': 1},
    )).thenAnswer((_) async => testJson.readAsString());

    final repository = GithubRepositorySearchRepository();
    final result = await repository.searchRepositories('flutter', 1);
    expect(result.length, 31);

    final first = result.first;
    expect(first.repositoryName, 'flutter');
    expect(first.description,
        'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
    expect(first.authorName, 'flutter');
    expect(first.authorImage,
        'https://avatars.githubusercontent.com/u/14101776?v=4');
    expect(first.watchersCount, 165427);
    expect(first.forksCount, 27304);
    expect(first.issuesCount, 12695);
    expect(first.stargazersCount, 165427);
    expect(first.lastUpdatedAt, DateTime.utc(2024, 10, 13, 20, 56, 50));
  });

  test('searchRepositories: NoHostException', () async {
    when(mockHttpService.get(
      'https://api.github.com/search/repositories',
      queryParameters: {'q': 'flutter', 'page': 1},
    )).thenAnswer(
          (_) => throw DioException(
        requestOptions: RequestOptions(),
        message: "Failed host lookup: 'api.github.com'",
      ),
    );

    final repository = GithubRepositorySearchRepository();
    expect(
          () => repository.searchRepositories('flutter', 1),
      throwsA(isA<NoHostException>()),
    );
  });

  test('searchRepositories: TooManyRequestsException', () async {
    when(mockHttpService.get(
      'https://api.github.com/search/repositories',
      queryParameters: {'q': 'flutter', 'page': 1},
    )).thenAnswer(
          (_) => throw DioException(
        requestOptions: RequestOptions(),
        message:
        "API rate limit exceeded for XXX.XXX.XXX.XXX. (But here's the good news: Authenticated requests get a h",
      ),
    );

    final repository = GithubRepositorySearchRepository();
    expect(
          () => repository.searchRepositories('flutter', 1),
      throwsA(isA<TooManyRequestsException>()),
    );
  });
}
