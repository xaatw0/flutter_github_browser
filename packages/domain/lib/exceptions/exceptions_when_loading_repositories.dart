sealed class ExceptionsWhenLoadingRepositories implements Exception {
  final String message;
  ExceptionsWhenLoadingRepositories(
      [this.message = 'An error occurred while loading repositories.']);

  @override
  String toString() => message;
}

/// ネットワークに繋がっていない状態の時
class NoHostException extends ExceptionsWhenLoadingRepositories {
  NoHostException([super.message = 'No network connection available.']);
}

/// APIアクセス制限エラー
/// アクセスしすぎで、サーバから拒否されたとき
class TooManyRequestsException extends ExceptionsWhenLoadingRepositories {
  TooManyRequestsException(
      [super.message =
      'Too many requests. The server has rejected your request.']);
}