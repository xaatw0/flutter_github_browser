import 'dart:convert';
import 'package:domain/services/http_service.dart';
import 'dto/github_search_repositories.dart';

class GithubRepositorySearchService {
  final HttpService httpService;

  const GithubRepositorySearchService(this.httpService);

  Future<GithubSearchRepositories> searchRepositories(
      String keyword, int page) async {
    final baseUrl = 'https://api.github.com/search/repositories';

    final json = await httpService.get(
      baseUrl,
      queryParameters: {'q': keyword, 'page': page},
    );
    return GithubSearchRepositories.fromJson(
        jsonDecode(json) as Map<String, dynamic>);
  }
}