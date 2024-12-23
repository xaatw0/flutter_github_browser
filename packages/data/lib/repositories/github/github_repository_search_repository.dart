import 'package:data/services/github/github_repository_search_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:domain/repositories/repository_search_repository.dart';
import 'package:domain/services/http_service.dart';
import 'package:domain/services/service_locator.dart';

import '../../services/github/dto/github_search_repositories.dart';
import '../../services/github/dto/repository_item.dart';

class GithubRepositorySearchRepository implements RepositorySearchRepository {
  /// ホストが見つからなかったときのエラー
  static const _kErrorMessageForNoHost = "Failed host lookup: 'api.github.com'";

  /// リクエストしすぎてホストに拒否られた時のメッセージの最初の部分<br/>
  /// 原文： "API rate limit exceeded for XXX.XXX.XXX.XXX. (But here's the good news: Authenticated requests get a h..."<br/>
  /// The primary rate limit for unauthenticated requests is 60 requests per hour. (https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api?apiVersion=2022-11-28)
  static const _kErrorPrefixMessageForTooManyRequests =
      'API rate limit exceeded for';

  late final HttpService _httpService = ServiceLocator.singleton().httpService;

  @override
  Future<List<GitRepositoryEntity>> searchRepositories(
      String keyword, int page) async {
    final service = GithubRepositorySearchService(_httpService);

    final GithubSearchRepositories repositories;
    try {
      repositories = await service.searchRepositories(keyword, page);
    } on Exception catch (ex) {
      final message = ex.toString();
      if (message.contains(_kErrorMessageForNoHost)) {
        throw NoHostException();
      }
      if (message.contains(_kErrorPrefixMessageForTooManyRequests)) {
        throw TooManyRequestsException();
      }
      rethrow;
    }

    return repositories.items.map(_convert).toList();
  }

  GitRepositoryEntity _convert(RepositoryItem item) {
    return GitRepositoryEntity(
      authorName: item.owner.login,
      repositoryName: item.name,
      description: item.description ?? '',
      authorImage: item.owner.avatarUrl,
      stargazersCount: item.stargazersCount,
      forksCount: item.forksCount,
      issuesCount: item.openIssuesCount,
      watchersCount: item.watchersCount,
      lastUpdatedAt: DateTime.parse(item.updatedAt),
    );
  }
}
