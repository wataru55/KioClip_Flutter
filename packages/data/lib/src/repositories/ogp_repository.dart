import 'package:ogp_data_extract/ogp_data_extract.dart';
import 'package:domain/models/ogp.dart' as domain;
import 'package:logger/logger.dart';

typedef OgpDataFetcher = Future<OgpData?> Function(String urlString);

/// OGP情報を取得するためのリポジトリクラス
class OgpRepository {
  static final _logger = Logger();

  // デフォルトのフェッチャー（本番環境用）
  static final OgpDataFetcher _defaultFetcher = (urlString) {
    return OgpDataExtract.execute(urlString);
  };

  final OgpDataFetcher _fetcher;

  OgpRepository({OgpDataFetcher? fetcher})
    : _fetcher = fetcher ?? _defaultFetcher;

  Future<domain.Ogp?> fetchOgp(String urlString) async {
    try {
      // ogp_data_extractパッケージのexecuteメソッドを使用
      final ogpData = await _fetcher(urlString);

      // ogpDataがnullの場合は失敗とみなす
      if (ogpData == null) {
        return null;
      }

      // titleが空の場合は、OGP取得失敗とみなす
      final title = ogpData.title ?? '';
      if (title.isEmpty) {
        return null;
      }

      // imageUrlを取得
      final imageUrl = ogpData.image;

      return domain.Ogp(title: title, imageUrl: imageUrl);
    } catch (e, stackTrace) {
      _logger.e('OGP取得エラー', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  static Future<domain.Ogp?> fetchOgpStatic(String urlString) async {
    return OgpRepository().fetchOgp(urlString);
  }
}
