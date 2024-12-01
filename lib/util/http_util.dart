import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stardeweather/util/cache_util.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';
import 'package:stardeweather/util/encrypt_util.dart';
import 'package:path_provider/path_provider.dart';

class HttpUtil {

  static Logger logger = Logger();

  // static final Future<String?> currentLocaleFuture = Devicelocale.currentLocale;

  static final Map<String, String> defaultHeaderMap = {
    'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
    // 'Accept-Encoding':'gzip, deflate, br',
    'Accept-Language': "zh-CN,zh;q=0.9,ko-KR;q=0.8,ko;q=0.7,ja-JP;q=0.6,ja;q=0.5",
    'Cache-Control':'max-age=0',
    // 'Connection':'keep-alive',
    // 'sec-ch-ua':'".Not/A)Brand";v="99", "Google Chrome";v="103", "Chromium";v="103"',
    // 'sec-ch-ua-mobile':'?0',
    // 'sec-ch-ua-platform':'"Windows"',
    // 'Sec-Fetch-Dest':'document',
    // 'Sec-Fetch-Mode':'navigate',
    // 'Sec-Fetch-Site':'none',
    // 'Sec-Fetch-User':'?1',
    // 'Upgrade-Insecure-Requests':'1',
    'User-Agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36',
  };

  static Dio? _dioInstance;

  static Dio getDioInstance() {
    _dioInstance ??= Dio()
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            // logger.d(" url : ${options.uri}"
            //  "\n header : ${options.headers}"
            //   "\n body : ${options.data}"
            // );
            return handler.next(options);
          }, 
          onResponse: (response, handler) {
            // logger.d("onResponse(${response.statusCode}) : ${response.data}");
            handler.next(response);
          }, 
          onError: (e, handler) {
            // logger.d("onError response(${e.response!.statusCode}) : ${e.response!.data}");
            return handler.next(e);
          })
        );
    (_dioInstance!.httpClientAdapter as IOHttpClientAdapter).createHttpClient = (){
      HttpClient client = HttpClient()
        ..badCertificateCallback = (X509Certificate cert, String host, int port) {
          return true;
        };
      int nowTime = DateTime.now().millisecondsSinceEpoch~/1000;
      if (nowTime<1731345590) {
        client
          ..findProxy = (Uri uri) {
            return "PROXY koocyton6:9l8k7j6h@h1.doopp.com:31294";
          }
          ..connectionFactory = (url, proxyHost, proxyPort) {
            return SecureSocket.startConnect(proxyHost!, proxyPort!);
          };
      }
      return client;
    };
    return _dioInstance!;
  }

  static Future<String?> stringFormPost(String url, {String? cacheKey, int? cacheDuration, Map<String, String>? headers, String? data}) async {
    String? str;
    if (cacheKey!=null) {
      String? str = CacheUtil.get(cacheKey, expireMinutes: cacheDuration);
      if (str!=null && str.isNotEmpty) {
        return str;
      }
    }
    return formPost(url, headers: headers, data: data).then((response){
      str = response.toString();
      if (cacheKey!=null && str!=null && str!.length>=10) {
        CacheUtil.set(cacheKey, str!);
      }
      return str;
    });
  }

  static Future<Response<T>> formPost<T>(String url, {Map<String, String>? headers, String? data}) {
    headers ??= {};
    headers["content-type"] = "application/x-www-form-urlencoded; charset=UTF-8";
    return getDioInstance().post<T>(url,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status!=null && status < 500; 
        },
        headers: buildHeaders(headers),
      ),
    );
  }

  static Future<ResponseBody?> dataGetDownload(String url, String savePath, {Map<String, String>? headers}) async {
    headers ??= {};
    try {
      return await (getDioInstance().download(
        url,
        savePath,
        options: Options(
          headers: buildHeaders(headers),
          contentType: Headers.jsonContentType,
          responseType: ResponseType.plain,
          maxRedirects: 2
        ),
      ))
      .then((response){
        return response.data;
      });
    }
    catch(e) {
      // log.info(e);
      return Future.value(null);
    }
  }

  static Future<String?> stringGet(String url, {String? cacheKey, int? cacheDuration, Map<String, String>? headers}) async {
    String? str;
    if (cacheKey!=null) {
      str = CacheUtil.get(cacheKey, expireMinutes: cacheDuration);
      if (str!=null) {
        // logger.i("cacheKey: $cacheKey ${str.length}");
        return str;
      }
    }
    headers ??= {};
    try {
      return await (getDioInstance().get(url,
        data: "",
        options: Options(
          headers: buildHeaders(headers),
          // contentType: Headers.textPlainContentType,
          // responseType: ResponseType.plain,
          // maxRedirects: 2
        ),
      ))
      .then((response){
        str = response.toString();
        if (cacheKey!=null && str!=null) {
          CacheUtil.set(cacheKey, str!);
        }
        return str;
      });
    }
    catch(e) {
      // logger.i("$e");
      return Future.value(null);
    }
  }

  static Future<Response<dynamic>> dataPost(String url, {Map<String, String>? headers, dynamic data}) {
    headers ??= {};
    return getDioInstance().post(url,
      data: data,
      options: Options(
        headers: buildHeaders(headers),
      ),
    );
  }

  static Future<dynamic> filePut(String url, String filePath, {Map<String, String>? headers}) {
    return File(filePath).readAsBytes()
      .then((b) async {
        return await getDioInstance().put(url,
          data: b,
          options: Options(
            headers: buildHeaders(headers),
          ),
        );
      })
      .then((response){
        return response.data;
      });
  }

  static Future<String?> stringPost(String url, {String? cacheKey, int? cacheDuration, Map<String, String>? headers, dynamic data}) async {
    if (cacheKey!=null) {
      cacheKey = EncryptUtil.md5(cacheKey);
    }
    String? str;
    if (cacheKey!=null) {
      str = CacheUtil.get(cacheKey, expireMinutes: cacheDuration);
      if (str!=null) {
        return str;
      }
    }
    try {
      return await getDioInstance().post(url,
        data: data,
        options: Options(
          headers: buildHeaders(headers),
        ),
      ).then((response){
        str = response.toString();
        if (cacheKey!=null && str!=null) {
          CacheUtil.set(cacheKey, str!);
        }
        return str;
      });
    }
    catch(e) {
      // log.info(e);
      // debugPrint(e.toString());
      return Future.value(null);
    }
  }

  static Future<String> getAbsolutePath(String relativePath) {
    return getApplicationDocumentsDirectory().then((appDir){
      return "${appDir.path}/$relativePath";
    });
  }

  static Future<String?> downFile(String url, String savePath, {Map<String, String>? headers}) {
    try {
      return getAbsolutePath(savePath).then((filePath){
        // Dio dio = Dio();
        // dio.options.connectTimeout = 100000;
        // dio.options.receiveTimeout = 100000;
        return getDioInstance().download(
          url,
          filePath,
          options: Options(
            headers: buildHeaders(headers??{}),
          ),
        ).then((response){
          return filePath;
        });
      });
    }
    catch(e) {
      // log.info(e);
      return Future.value(null);
    }
  }

  static Map<String, String> buildHeaders(Map<String, String>? headers) {
    Map<String, String> map = {};
    map.addAll(defaultHeaderMap);
    if (headers!=null) {
      for(String key in headers.keys) {
        map[key] = headers[key]!;
      }
    }
    // logger.i("$map");
    return map;
  }
  
  static Map<String,String> getCookieMap(Headers? headers) {
    final Map<String,String> cookieMap = {};
    if (headers==null) {
      return cookieMap;
    }
    headers.forEach((name, values){
      if (name == HttpHeaders.setCookieHeader) {
        for (var cookie in values) {
          String key = cookie.substring(0, cookie.indexOf('='));
          String value = cookie.substring(key.length + 1, cookie.indexOf(';'));
          cookieMap[key] = value;
        }
      }
    });
    return cookieMap;
  }
  
  static String? getCookiesFormatted(Headers? headers) {
    if (headers==null) {
      return null;
    }
    Map<String,String> cookieMap = getCookieMap(headers);
    String cookiesFormatted = "";
    for (String key in cookieMap.keys) {
      cookiesFormatted += "$key=${cookieMap[key]};";
    }
    return cookiesFormatted;
  }
}