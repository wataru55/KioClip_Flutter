import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:data/data.dart' as data;

// AppDatabaseのインスタンスを供給するProvider
// アプリ全体でただ一つのインスタンスを共有するため、通常のProviderを使う
final databaseProvider = Provider<data.AppDatabase>((ref) {
  return data.AppDatabase();
});
