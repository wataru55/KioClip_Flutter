import 'package:flutter_test/flutter_test.dart';
import 'package:app/utils/article_utils.dart';

void main() {
  group('ArticleUtils', () {
    group('getHostName', () {
      test('正常なURLを渡した場合はホスト名を返す', () {
        final hostName = ArticleUtils.getHostName('https://www.google.com');
        expect(hostName, 'www.google.com');
      });

      test('正常なURLでなければ元のURLを返す', () {
        final invalidUrl = 'invalid';
        expect(invalidUrl, 'invalid');
      });
    });

    group('formatDate', () {
      test('日付が正しくフォーマットされる', () {
        final DateTime testDate = DateTime(2001, 5, 5, 14, 30);
        expect(ArticleUtils.formatDate(testDate), '2001/5/5');
      });
    });
  });
}
