import 'package:data/data.dart' as data;
import 'package:domain/models/group.dart' as domain;

/// data.Group を domain.Group に変換する拡張メソッド
extension GroupMapper on data.Group {
  domain.Group toDomainModel() {
    return domain.Group(id: id, name: name);
  }
}
