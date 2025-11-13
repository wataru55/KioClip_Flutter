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

final groupNotifierProvider = AsyncNotifierProvider<GroupNotifier, void>(
  GroupNotifier.new,
);

class GroupNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// グループを追加する
  Future<void> addGroup(String name) async {
    final db = ref.read(databaseProvider);

    // 1. domain層のモデルをfactory constructorを使って生成する
    final domainGroup = domain.Group.create(name: name);

    // 2. domain層のモデルをDomainToDataGroupMapperでdata層のモデルに変換する
    final dataGroupCompanion = domainGroup.toDataModel();

    // 3. data層のモデルをinsertする
    await db.into(db.groups).insert(dataGroupCompanion);

    // 4. グループの一覧を更新する
    ref.invalidate(groupListProvider);
  }
}
