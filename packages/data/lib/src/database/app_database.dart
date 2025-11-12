import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:data/src/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Articles, Groups])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // データベースファイルを保存するフォルダを取得
    final dbFolder = await getApplicationDocumentsDirectory();
    // データベースファイルのパスを構築
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    // ネイティブ環境（iOS/Android）用のデータベース接続を開く
    return NativeDatabase(file);
  });
}
