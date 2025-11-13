import 'package:data/src/database/app_database.dart' as data;
import 'package:domain/models/group.dart' as domain;

/// data.Group を domain.Group に変換する拡張メソッド
extension DataToDomainGroupMapper on data.Group {
  domain.Group toDomainModel() {
    return domain.Group(id: id, name: name);
  }
}

/// domain.Group を data.GroupsCompanion に変換する拡張メソッド
extension DomainToDataGroupMapper on domain.Group {
  data.GroupsCompanion toDataModel() {
    return data.GroupsCompanion.insert(id: id, name: name);
  }
}
