import 'package:flutter_test/flutter_test.dart';
import 'package:data/data.dart' as data;
import 'package:domain/models/group.dart' as domain;

class TestHelper {
  static data.Group createDataGroup({
    String id = '1',
    String name = 'Test Group',
  }) {
    return data.Group(id: id, name: name);
  }

  static domain.Group createDomainGroup({
    String id = '1',
    String name = 'Test Group',
  }) {
    return domain.Group(id: id, name: name);
  }
}

void main() {
  group('DataToDomainGroupMapper', () {
    group('toDomainModel', () {
      test('data.Groupが正しくdomain.Groupに変換される', () {
        final dataGroup = TestHelper.createDataGroup();
        final domainGroup = dataGroup.toDomainModel();

        expect(domainGroup.id, dataGroup.id);
        expect(domainGroup.name, dataGroup.name);
      });
    });

    group('toDataModel', () {
      test('domain.Groupが正しくdata.GroupsCompanionに変換される', () {
        final domainGroup = TestHelper.createDomainGroup();
        final dataGroup = domainGroup.toDataModel();

        expect(dataGroup.id.value, domainGroup.id);
        expect(dataGroup.name.value, domainGroup.name);
      });
    });
  });
}
