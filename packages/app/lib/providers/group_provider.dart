import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:data/data.dart' as data;
import 'package:domain/models/group.dart' as domain;

import 'package:app/providers/database_provider.dart';

// グループの一覧（List<Group>）を非同期で供給するProvider
// データベースからの取得は時間がかかるため、FutureProviderを使う
final groupListProvider = FutureProvider<List<domain.Group>>((ref) async {
  // databaseProviderを読み取り、AppDatabaseのインスタンスを取得
  final db = ref.watch(databaseProvider);

  // 1. データベースから全てのグループを取得する (select文)
  final dataGroups = await db.select(db.groups).get();

  // 2. 取得したdata.Groupのリストを、domain.Groupのリストに変換する
  final domainGroups = dataGroups
      .map((dataGroup) => dataGroup.toDomainModel())
      .toList();

  return domainGroups;
});
