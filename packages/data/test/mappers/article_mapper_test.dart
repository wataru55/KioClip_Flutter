import 'package:flutter_test/flutter_test.dart';
import 'package:domain/models/article.dart' as domain;
import 'package:domain/models/ogp.dart' as domain;
import 'package:data/data.dart' as data;

class TestHelper {
  static domain.Article createDomainArticleWithOgp({
    String id = '1',
    String urlString = 'https://example.com',
    DateTime? createdAt,
    domain.Ogp ogp = const domain.Ogp(
      title: 'Test Article',
      imageUrl: 'https://example.com/image.jpg',
    ),
  }) {
    return domain.Article(
      id: id,
      urlString: urlString,
      createdAt: createdAt ?? DateTime(2025, 11, 11),
      ogp: ogp,
    );
  }

  static domain.Article createDomainArticleWithNoOgp({
    String id = '1',
    String urlString = 'https://example.com',
    DateTime? createdAt,
  }) {
    return domain.Article(
      id: id,
      urlString: urlString,
      createdAt: createdAt ?? DateTime(2025, 11, 11),
    );
  }

  static data.Article createDataArticleWithOgp({
    String id = '1',
    String urlString = 'https://example.com',
    DateTime? createdAt,
    domain.Ogp ogp = const domain.Ogp(
      title: 'Test Article',
      imageUrl: 'https://example.com/image.jpg',
    ),
  }) {
    return data.Article(
      id: id,
      urlString: urlString,
      createdAt: createdAt ?? DateTime(2025, 11, 11),
      ogpTitle: ogp.title,
      ogpImageUrl: ogp.imageUrl,
    );
  }

  static data.Article createDataArticleWithNoOgp({
    String id = '1',
    String urlString = 'https://example.com',
    DateTime? createdAt,
  }) {
    return data.Article(
      id: id,
      urlString: urlString,
      createdAt: createdAt ?? DateTime(2025, 11, 11),
    );
  }
}

void main() {
  group('DomainToDataArticleMapper', () {
    group('toDataModel', () {
      test('OGP情報を含むArticleが正しく変換される', () {
        final domain.Article domainArticle =
            TestHelper.createDomainArticleWithOgp();

        final data.ArticlesCompanion articleCompanion = domainArticle
            .toDataModel();

        expect(articleCompanion.id.value, domainArticle.id);
        expect(articleCompanion.urlString.value, domainArticle.urlString);
        expect(articleCompanion.createdAt.value, domainArticle.createdAt);
        expect(articleCompanion.ogpTitle.value, domainArticle.ogp?.title);
        expect(articleCompanion.ogpImageUrl.value, domainArticle.ogp?.imageUrl);
      });

      test('OGP情報を含まないArticleが正しく変換される', () {
        final domain.Article domainArticle =
            TestHelper.createDomainArticleWithNoOgp();

        final data.ArticlesCompanion articleCompanion = domainArticle
            .toDataModel();

        expect(articleCompanion.id.value, domainArticle.id);
        expect(articleCompanion.urlString.value, domainArticle.urlString);
        expect(articleCompanion.createdAt.value, domainArticle.createdAt);
        expect(articleCompanion.ogpTitle.value, null);
        expect(articleCompanion.ogpImageUrl.value, null);
      });
    });

    group('toDomainModel', () {
      test('ogp情報がないdata.Articleが正しく変換される', () {
        final data.Article dataArticle =
            TestHelper.createDataArticleWithNoOgp();

        final domain.Article domainArticle = dataArticle.toDomainModel();

        expect(domainArticle.id, dataArticle.id);
        expect(domainArticle.urlString, dataArticle.urlString);
        expect(domainArticle.createdAt, dataArticle.createdAt);
        expect(domainArticle.ogp, null);
      });

      test('ogp情報があるdata.Articleが正しく変換される', () {
        final data.Article dataArticle = TestHelper.createDataArticleWithOgp();

        final domain.Article domainArticle = dataArticle.toDomainModel();
        expect(domainArticle.id, dataArticle.id);
        expect(domainArticle.urlString, dataArticle.urlString);
        expect(domainArticle.createdAt, dataArticle.createdAt);
        expect(domainArticle.ogp?.title, dataArticle.ogpTitle);
        expect(domainArticle.ogp?.imageUrl, dataArticle.ogpImageUrl);
      });

      test('ogp情報にTitleがない場合はogp情報のないdata.Articleにされる', () {
        final data.Article dataArticle = data.Article(
          id: '1',
          urlString: 'https://example.com',
          createdAt: DateTime.now(),
          ogpImageUrl: 'https://example.com/image.jpg',
        );

        final domain.Article domainArticle = dataArticle.toDomainModel();
        expect(domainArticle.id, dataArticle.id);
        expect(domainArticle.urlString, dataArticle.urlString);
        expect(domainArticle.createdAt, dataArticle.createdAt);
        expect(domainArticle.ogp, null);
      });
    });
  });
}
