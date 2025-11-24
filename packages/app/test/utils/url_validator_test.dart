import 'package:flutter_test/flutter_test.dart';
import 'package:app/utils/url_validator.dart';

void main() {
  test('正常なURLを渡した場合はnullを返す', () {
    final String urlString = 'https://www.google.com';
    expect(validateUrl(urlString), null);
  });

  test('パースに失敗した場合はエラーメッセージを返す', () {
    final invalidUrl = 'http://[invalid';
    expect(validateUrl(invalidUrl), '無効なURL形式です');
  });

  test('http:// または https:// から始まらないURLを渡した場合はエラーメッセージを返す', () {
    final invalidUrl = 'www.google.com';
    expect(validateUrl(invalidUrl), 'http:// または https:// から始まるURLを入力してください');
  });
}
