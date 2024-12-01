import 'package:stardeweather/util/cache_util.dart';
import 'package:stardeweather/util/http_util.dart';
import 'package:logger/logger.dart';

class HtmlFetchService {

  static Logger logger = Logger();

  static const String baseUrl = "https://www.example.net";

  static const Map<String, String> defaultHeaders = {
    "x-requested-with":"XMLHttpRequest",
    'authority':'www.example.net',
    'accept-language':'zh-CN,zh;q=0.9,en;q=0.8'
  };

  static Future<String?> getBookPage(String bookLink) async {
    String url = baseUrl + bookLink;
    Map<String, String> headers = {};
    headers.addAll(defaultHeaders);
    return await HttpUtil.stringGet(url, cacheKey: bookLink, cacheDuration: 3600, headers: headers);
  }

  static Future<String?> getChapterPage(String chapterLink) async {
    String url = baseUrl + chapterLink;
    Map<String, String> headers = {};
    headers.addAll(defaultHeaders);
    String? cookiesFormatted = CacheUtil.get("cookiesFormatted");
    if (cookiesFormatted==null && cookiesFormatted=="") {
      return "";
    }
    headers["Cookie"] = cookiesFormatted!;
    return await HttpUtil.stringGet(url, headers: headers);
  }
}
