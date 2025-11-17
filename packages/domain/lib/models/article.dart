import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain/models/ogp.dart';
import 'package:uuid/uuid.dart';

part 'article.freezed.dart';

const uuid = Uuid();

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

  factory Article.create({
    required String urlString,
    String Function()? idGenerator,
    DateTime? now,
  }) {
    final generateId = idGenerator ?? const Uuid().v4;

    return Article(
      id: generateId(),
      urlString: urlString,
      createdAt: DateTime.now(),
    );
  }
}
