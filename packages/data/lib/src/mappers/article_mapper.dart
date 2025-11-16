import 'package:data/data.dart';
import 'package:data/src/database/app_database.dart' as data;
import 'package:domain/models/article.dart' as domain;
import 'package:domain/models/ogp.dart' as domain_ogp;
import 'package:drift/drift.dart';

extension DomainToDataArticleMapper on domain.Article {
  data.ArticlesCompanion toDataModel() {
    return data.ArticlesCompanion.insert(
      id: id,
      urlString: urlString,
      createdAt: createdAt,

      ogpTitle: Value(ogp?.title),
      ogpImageUrl: Value(ogp?.imageUrl),
    );
  }
}

extension DataToDomainArticleMapper on data.Article {
  domain.Article toDomainModel() {
    final ogp = switch (ogpTitle) {
      final title? => domain_ogp.Ogp(title: title, imageUrl: ogpImageUrl),
      _ => null,
    };

    return domain.Article(
      id: id,
      urlString: urlString,
      createdAt: createdAt,
      ogp: ogp,
    );
  }
}
