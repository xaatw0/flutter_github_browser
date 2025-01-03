# Flutterアーキテクチャ徹底入門
Zennの本[「Flutterアーキテクチャ徹底入門」](https://zenn.dev/sakusin/books/8108065546e48b)のソースコードです。

## 本の内容
「Architecting Flutter apps(GoogleのFlutterアーキテクチャの概要に関する記事)」をベースに、
いままでの業務経験による自分なりの工夫を加える形でプロジェクト作成しました。そのプロジェクト構成と作成の過程を記載してます。
「Githubのレポジトリ検索」という簡単なアプリですが、スケーラブルなFlutterアプリにするためのアーキテクチャ構造が学べます。
Flutter初心者向けではない。

## インストール
```
git clone https://github.com/xaatw0/flutter_github_browser.git
dart pub global activate fvm
fvm use --force
fvm flutter pub get
cd packages/ui
fvm flutter gen-l10n
cd ../..
```

## 実行
```
cd packages/executable
- Githubとの通信で実行
fvm flutter run
- ダミーデータで実行
fvm flutter run -t test_execute/main_with_dummy_data.dart
```

## テスト
- Data層
```
cd packages/data
fvm dart run build_runner build
fvm flutter test
cd ../..
```