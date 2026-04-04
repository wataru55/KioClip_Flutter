/// 記事関連のユーティリティ関数
class ArticleUtils {
  ArticleUtils._();

  /// URLからホスト名を取得する
  static String getHostName(String urlString) {
    try {
      final uri = Uri.parse(urlString);
      return uri.host;
    } catch (e) {
      // パースに失敗した場合は元のURLを返す
      return urlString;
    }
  }

  /// 日付をフォーマットする（時間は含めない）
  static String formatDate(DateTime date) {
    final localDate = date.toLocal();
    return '${localDate.year}/${localDate.month}/${localDate.day}';
  }
}
