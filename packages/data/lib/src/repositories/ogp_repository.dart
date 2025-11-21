import 'package:ogp_data_extract/ogp_data_extract.dart';
import 'package:domain/models/ogp.dart' as domain;
import 'package:logger/logger.dart';

/// OGP情報を取得するためのリポジトリクラス
class OgpRepository {
  static final _logger = Logger();

  static Future<domain.Ogp?> fetchOgp(String urlString) async {
    try {
      // ogp_data_extractパッケージのexecuteメソッドを使用
      final ogpData = await OgpDataExtract.execute(urlString);

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
}
