import '../entities/git_repository_entity.dart';

abstract interface class RepositorySearchRepository {
  Future<List<GitRepositoryEntity>> searchRepositories(
      String keyword,
      int page,
      );
}