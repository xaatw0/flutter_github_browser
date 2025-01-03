import 'package:domain/entities/git_repository_entity.dart';
import 'package:test/test.dart';

void main() {
  group('GitRepositoryEntity Tests', () {
    // 1. 通常のコンストラクタからクラスを作成
    test('Create GitRepositoryEntity with constructor', () {
      final entity = GitRepositoryEntity(
        authorName: 'John Doe',
        repositoryName: 'flutter/flutter',
        description: 'Flutter SDK',
        authorImage: 'http://example.com/john.jpg',
        stargazersCount: 50000,
        forksCount: 12000,
        issuesCount: 200,
        watchersCount: 10000,
        lastUpdatedAt: DateTime.parse('2024-01-01T12:00:00Z'),
      );

      expect(entity.authorName, 'John Doe');
      expect(entity.repositoryName, 'flutter/flutter');
      expect(entity.description, 'Flutter SDK');
      expect(entity.stargazersCount, 50000);
      expect(entity.forksCount, 12000);
      expect(entity.issuesCount, 200);
      expect(entity.watchersCount, 10000);
      expect(entity.lastUpdatedAt, DateTime.parse('2024-01-01T12:00:00Z'));
    });

    // 2. Jsonからクラスを作成し、再度Jsonに変換して内容を確認
    test('Create GitRepositoryEntity fromJson and toJson', () {
      final json = {
        'authorName': 'John Doe',
        'repositoryName': 'flutter/flutter',
        'description': 'Flutter SDK',
        'authorImage': 'http://example.com/john.jpg',
        'stargazersCount': 50000,
        'forksCount': 12000,
        'issuesCount': 200,
        'watchersCount': 10000,
        'lastUpdatedAt': '2024-01-01T12:00:00.000Z',
      };

      final entity = GitRepositoryEntity.fromJson(json);
      final jsonBack = entity.toJson();

      expect(jsonBack['authorName'], json['authorName']);
      expect(jsonBack['repositoryName'], json['repositoryName']);
      expect(jsonBack['description'], json['description']);
      expect(jsonBack['stargazersCount'], json['stargazersCount']);
      expect(jsonBack['forksCount'], json['forksCount']);
      expect(jsonBack['issuesCount'], json['issuesCount']);
      expect(jsonBack['watchersCount'], json['watchersCount']);
      expect(jsonBack['lastUpdatedAt'], json['lastUpdatedAt']);
    });
  });
}
