import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/repositories/repository_search_repository.dart';

enum SearchRepositoriesStatus {
  noKeyword(false, true, false),
  inputtingKeyword(false, true, true),
  searchingWithoutData(true, false, false),
  showFoundData(false, false, true),
  searchingWithData(true, false, false);

  const SearchRepositoriesStatus(
      this.isLoading, this.canInput, this.canTapSearch);

  final bool isLoading;
  final bool canInput;
  final bool canTapSearch;
}
// 続く
// 続き
class SearchRepositoriesModel {
  final RepositorySearchRepository _repositorySearchRepository;

  final SearchRepositoriesStatus status;

  /// 検索キーワード
  final String keyword;

  /// 検索対象のページが何番目か
  final int page;

  /// 検索結果として取得したリポジトリのリスト
  final List<GitRepositoryEntity> entities;

  /// 全てのフィールドを含むコンストラクタ
  const SearchRepositoriesModel._(
      this._repositorySearchRepository, {
        required this.status,
        required this.keyword,
        required this.page,
        required this.entities,
      });

  factory SearchRepositoriesModel.init(
      RepositorySearchRepository repositorySearchRepository) {
    return SearchRepositoriesModel._(
      repositorySearchRepository,
      status: SearchRepositoriesStatus.noKeyword,
      keyword: '',
      page: 0,
      entities: [],
    );
  }

  SearchRepositoriesModel reset() {
    return SearchRepositoriesModel._(
      _repositorySearchRepository,
      status: SearchRepositoriesStatus.inputtingKeyword,
      keyword: keyword,
      page: 0,
      entities: [],
    );
  }

  SearchRepositoriesModel changeKeyword(String keyword) {
    final nextStatus = keyword.isEmpty
        ? SearchRepositoriesStatus.noKeyword
        : SearchRepositoriesStatus.inputtingKeyword;

    return SearchRepositoriesModel._(
      _repositorySearchRepository,
      status: nextStatus,
      keyword: keyword,
      page: page,
      entities: [],
    );
  }

  SearchRepositoriesModel startSearch() {
    return SearchRepositoriesModel._(
      _repositorySearchRepository,
      status: entities.isEmpty
          ? SearchRepositoriesStatus.searchingWithoutData
          : SearchRepositoriesStatus.searchingWithData,
      keyword: keyword,
      page: page + 1,
      entities: entities,
    );
  }

  SearchRepositoriesModel finishSearch(List<GitRepositoryEntity> newEntities) {
    final entities = [...this.entities, ...newEntities];

    return SearchRepositoriesModel._(
      _repositorySearchRepository,
      status: entities.isEmpty
          ? SearchRepositoriesStatus.inputtingKeyword
          : SearchRepositoriesStatus.showFoundData,
      keyword: keyword,
      page: page,
      entities: entities,
    );
  }

  Future<List<GitRepositoryEntity>> searchRepositories() {
    return _repositorySearchRepository.searchRepositories(keyword, page);
  }
}
