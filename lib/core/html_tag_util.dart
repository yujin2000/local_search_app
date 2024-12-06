class HtmlTagUtil {
  static RegExp tag = RegExp(r'<[^>]*>|&[^;]+;');

  /// 태그 변경
  static String replace(String value) {
    return value.replaceAll(tag, '');
  }
}
