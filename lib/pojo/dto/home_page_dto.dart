import 'package:stardeweather/util/object_util.dart';

class HomePageBook {
  String? bookId;
  String? link;
  String? image;
  String? name;
  String? chapterNumber;
  String? score;
  String? pv;
  String? author;
  String? intro;
  
  static HomePageBook? fromMap(dynamic dyn) {
    if (dyn==null) {
      return null;
    }
    return HomePageBook()
      ..link   = ObjectUtil.toStr(dyn["link"])
      ..image  = ObjectUtil.toStr(dyn["image"])
      ..name   = ObjectUtil.toStr(dyn["name"])
      ..score  = ObjectUtil.toStr(dyn["score"])
      ..pv     = ObjectUtil.toStr(dyn["pv"])
      ..author = ObjectUtil.toStr(dyn["author"])
      ..intro = ObjectUtil.toStr(dyn["intro"])
      ..chapterNumber = ObjectUtil.toStr(dyn["chapter_number"]);
  }
  static List<HomePageBook> fromMapList(dynamic mapList) {
    List<HomePageBook> list = [];
    if (mapList==null || mapList.length<1) {
      return list;
    }
    for (var map in mapList) {
      HomePageBook? cc = fromMap(map);
      if (cc!=null) {
        list.add(cc);
      }
    }
    return list;
  }
}
