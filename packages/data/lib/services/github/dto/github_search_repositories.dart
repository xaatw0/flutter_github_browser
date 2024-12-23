import 'repository_item.dart';

class GithubSearchRepositories {
  final int totalCount;
  final bool incompleteResults;
  final List<RepositoryItem> items;

  GithubSearchRepositories({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory GithubSearchRepositories.fromJson(Map<String, dynamic> json) {
    return GithubSearchRepositories(
      totalCount: json['total_count'],
      incompleteResults: json['incomplete_results'],
      items: (json['items'] as List<dynamic>)
          .map((item) => RepositoryItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'incomplete_results': incompleteResults,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
