import 'package:get/get.dart';

class ObjectUtil {

  static int? toInt(dynamic dyn) {
    return (dyn==null || !dyn.toString().isNum) 
      ? null 
      : int.parse(dyn.toString());
  }

  static String? toStr(dynamic dyn) {
    return dyn?.toString();
  }

  static List<String>? toStrList(dynamic dyn) {
    List<String> list = [];
    for (dynamic value in dyn) {
      list.add(value);
    }
    return list;
  }

  static DateTime? toDateTime(dynamic dyn) {
    return dyn==null ? null : DateTime.parse(dyn.toString());
  }

  static bool toBool(dynamic dyn) {
    return dyn.toString()=="true" ? true : false;
  }

  static bool isNotEmpty(dynamic dyn) {
    return !isEmpty(dyn);
  }

  static bool isEmpty(dynamic dyn) {
    if (dyn==null) {
      return true;
    }
    if (dyn is String) {
      return dyn=="";
    }
    else if (dyn is List) {
      return dyn.isEmpty;
    }
    else if (dyn is Map) {
      return dyn.isEmpty;
    }
    return false;
  }

  static bool isEmail(String? email) {
    if (email==null) {
      return false;
    }
    // 正则表达式模式，用于匹配电子邮件地址
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(pattern);
    // 使用正则表达式匹配电子邮件地址
    return regExp.hasMatch(email);
  }

}