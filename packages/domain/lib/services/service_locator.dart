import '../repositories/repository_search_repository.dart';
import 'http_service.dart';

class ServiceLocator {
  static late final ServiceLocator _instance;

  static ServiceLocator singleton() {
    return _instance;
  }

  ServiceLocator._(
      this._httpService,
      this._repositorySearchRepository,
      );

  static void init(
      HttpService httpService,
      RepositorySearchRepository repositorySearchRepository,
      ) {
    _instance = ServiceLocator._(
      httpService,
      repositorySearchRepository,
    );
  }

  final HttpService _httpService;
  HttpService get httpService => singleton()._httpService;

  final RepositorySearchRepository _repositorySearchRepository;
  RepositorySearchRepository get repositorySearchRepository =>
      singleton()._repositorySearchRepository;
}