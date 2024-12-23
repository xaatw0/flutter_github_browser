class GitRepositoryEntity {
  /// 作者の名前
  final String authorName;

  /// レポジトリの名前
  final String repositoryName;

  /// レポジトリの概要
  final String description;

  /// 作者の画像URL
  final String authorImage;

  /// スター数
  final int stargazersCount;

  /// フォーク数
  final int forksCount;

  /// イシュー数
  final int issuesCount;

  /// ウォッチャー数
  final int watchersCount;

  /// 最終更新日時
  final DateTime lastUpdatedAt;

  /// 全てのフィールドを含むコンストラクタ
  GitRepositoryEntity({
    required this.authorName,
    required this.repositoryName,
    required this.description,
    required this.authorImage,
    required this.stargazersCount,
    required this.forksCount,
    required this.issuesCount,
    required this.watchersCount,
    required this.lastUpdatedAt,
  });

  /// JSONからクラスを作成するファクトリコンストラクタ
  factory GitRepositoryEntity.fromJson(Map<String, dynamic> json) {
    return GitRepositoryEntity(
      authorName: json['authorName'],
      repositoryName: json['repositoryName'],
      description: json['description'],
      authorImage: json['authorImage'],
      stargazersCount: json['stargazersCount'],
      forksCount: json['forksCount'],
      issuesCount: json['issuesCount'],
      watchersCount: json['watchersCount'],
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt']),
    );
  }

  /// クラスをJSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'repositoryName': repositoryName,
      'description': description,
      'authorImage': authorImage,
      'stargazersCount': stargazersCount,
      'forksCount': forksCount,
      'issuesCount': issuesCount,
      'watchersCount': watchersCount,
      'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
    };
  }
}