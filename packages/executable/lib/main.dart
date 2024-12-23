import 'package:data/http/dio_http_service.dart';
import 'package:data/repositories/github/github_repository_search_repository.dart';
import 'package:domain/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:ui/main.dart';

void main() {
  ServiceLocator.init(DioHttpService(), GithubRepositorySearchRepository());

  runApp(const MainApp());
}