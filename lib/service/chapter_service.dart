import 'package:stardeweather/pojo/dto/home_page_dto.dart';
import 'package:stardeweather/service/html_fetch_service.dart';
import 'package:stardeweather/util/match_util.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class ChapterService {

  static Logger logger = Logger();

  static void fetchChapterInfo(String chapterLink, Function(HomePageBook, HomePageBook, List<String>) fun) {
    HtmlFetchService.getChapterPage(chapterLink).then((html) async {
      String regex = await rootBundle.loadString("assets/regex/regex_chapter_info.reg");
      Iterable<RegExpMatch> matchs = MatchUtil.matchAll(regex, html);
      List<String> images = [];
      for (var match in matchs) {
        images.add(match.group(1).toString());
      }
      HomePageBook book = HomePageBook();
      fun(book, book, images);
    });
  }
}
