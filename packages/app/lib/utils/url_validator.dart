/// URLの形式が正しいかどうかをチェックする
String? validateUrl(String? value) {
  // 1. null or 空 or スペースのみの文字列は、この関数ではエラーとしない
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  final urlString = value.trim();

  // 2. Uri.tryParseを使い、パースに失敗しても例外を投げずにnullを返すようにする
  final Uri? uri = Uri.tryParse(urlString);

  // パース自体に失敗した場合は無効
  if (uri == null) {
    return '無効なURL形式です';
  }

  // 3. 'http'/'https'のスキームを持ち、ホスト部が空でないことを確認する
  if ((uri.scheme != 'http' && uri.scheme != 'https') || uri.host.isEmpty) {
    return 'http:// または https:// から始まるURLを入力してください';
  }

  // 全てのチェックを通過
  return null;
}
