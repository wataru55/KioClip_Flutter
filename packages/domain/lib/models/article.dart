import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain/models/ogp.dart';

part 'article.freezed.dart';

@freezed
class Article with _$Article {
  const factory Article({
    // 記事を識別するための一意のID
    required String id,
    // 記事のURL
    required String urlString,
    // 記事の作成日時
    required DateTime createdAt,
    // OGP情報
    Ogp? ogp,
  }) = _Article;
}
