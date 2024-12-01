import 'package:stardeweather/util/http_util.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoginService {

  static Logger logger = Logger();

  static const String baseUrl = "https://www.example.net";

  static const Map<String, String> defaultHeaders = {
    "x-requested-with":"chrome",
    'authority':'www.example.net',
    'accept-language':'zh-CN,zh;q=0.9,en;q=0.8'
  };

  static Future<String?> loginProc(String email, String password) async {
    email = Uri.encodeComponent(email);
    password = Uri.encodeComponent(password);
    Map<String, String> headers = {};
    headers.addAll(defaultHeaders);
    headers["X-Requested-With"] = "XMLHttpRequest";
    headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8";
    String url = "$baseUrl/member/login_proc";
    String data = "redirect=https%3A%2F%2Fwww.example.net%2F&userId=$email&phoneCountryNo=886&phoneNo=&userPw=$password&saveId=1&autoLogin=1";
    await HttpUtil.dataPost(url, headers: headers, data:data).then((resp){
      return "";
    });
  }

  static Future<void> joinProcRequest(String email, String password, {Function(Response<dynamic>)? onResponse}) async {
    email = Uri.encodeComponent(email);
    password = Uri.encodeComponent(password);
    Map<String, String> headers = {};
    headers.addAll(defaultHeaders);
    headers["Referer"] = "$baseUrl/my/giftbox";
    headers["X-Requested-With"] = "XMLHttpRequest";
    headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8";
    String url = "$baseUrl/member/join_proc";
    String data = "redirect=%2Fmy%2Fgiftbox&userId=$email&phoneCountryNo=886&certtype=sendCertNo&isSendCertNo=&phoneNo=&userPw=$password&certNo=&agreementAll=1&agree1=1&agree2=1&agree3=1&saveId=1&autoLogin=1";
    HttpUtil.dataPost(url, headers: headers, data:data).then((resp){
      if (onResponse!=null) {
        onResponse(resp);
      }
    });
  }

}
