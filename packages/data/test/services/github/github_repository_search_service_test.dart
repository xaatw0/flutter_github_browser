import 'dart:io';

import 'package:data/http/dio_http_service.dart';
import 'package:data/services/github/github_repository_search_service.dart';
import 'package:domain/services/http_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'github_repository_search_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpService>(),
])
main() {
  final testJson =
  File('test/services/github/github_repository_search_service_test.json');

  test('exists', () {
    expect(testJson.existsSync(), true);
  });

  test('searchRepositories with mock', () async {
    final mockClient = MockHttpService();
    when(mockClient.get(
      'https://api.github.com/search/repositories',
      queryParameters: {'q': 'flutter', 'page': 1},
    )).thenAnswer((_) async => testJson.readAsString());

    final service = GithubRepositorySearchService(mockClient);
    final result = await service.searchRepositories('flutter', 1);

    expect(result.totalCount, 750330);
    expect(result.items.length, 31);

    final first = result.items.first;
    expect(first.name, 'flutter');
    expect(first.description,
        'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
    expect(first.owner.login, 'flutter');
    expect(first.owner.avatarUrl,
        'https://avatars.githubusercontent.com/u/14101776?v=4');
    expect(first.watchersCount, 165427);
    expect(first.forksCount, 27304);
    expect(first.openIssuesCount, 12695);
    expect(first.stargazersCount, 165427);
    expect(first.updatedAt, '2024-10-13T20:56:50Z');
  });

  test('searchRepositories with real data', () async {
    final service = GithubRepositorySearchService(DioHttpService());
    final result = await service.searchRepositories('flutter', 1);
    expect(result.items.length, 30);
  });
}
