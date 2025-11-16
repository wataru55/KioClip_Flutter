import 'package:freezed_annotation/freezed_annotation.dart';

part 'ogp.freezed.dart';

@freezed
class Ogp with _$Ogp {
  const factory Ogp({
    // OGPのタイトル
    required String title,
    // OGPの画像URL
    String? imageUrl,
  }) = _Ogp;
}
