import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'group.freezed.dart';

const uuid = Uuid();

@freezed
abstract class Group with _$Group {
  const factory Group({
    // グループを識別するための一意のID
    required String id,
    // グループの名前
    required String name,
  }) = _Group;

  factory Group.create({required String name}) {
    return Group(id: uuid.v4(), name: name);
  }
}
