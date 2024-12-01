import 'package:flutter/material.dart';
import 'package:stardeweather/easy/scroll_utils.dart';
import 'package:path_provider/path_provider.dart';

class UI {

  late double topHeight;
  late double headHeight;
  late double footHeight;
  late double windowWidth;
  late double windowHeight;
  late double keybordHeight;
  late double bodyTrailingEdge;
  late double floatingButtonWidth;
  ScrollPhysics physics = const FastBouncingScrollPhysics();
  EdgeInsets zeroEdgeInsets = const EdgeInsets.all(0);
  Color bgColor = Colors.green.shade100;
  Color fgColor = Colors.black87.withOpacity(0.7);
  Color appNavBgColor = const Color(0xFFBBDEFB);
  Color systemNavBgColor = const Color.fromARGB(255, 145, 204, 135);
  Color maskSystemNavBgColor = const Color.fromARGB(255, 65, 94, 65);
  late String applicationDir;

  void init(BuildContext context) {
    MediaQueryData windowMediaQueryData = MediaQueryData.fromView(View.of(context));
    topHeight = windowMediaQueryData.padding.top;
    headHeight = topHeight + 56;
    footHeight = 56;
    windowWidth = windowMediaQueryData.size.width;
    windowHeight = windowMediaQueryData.size.height;
    keybordHeight = windowMediaQueryData.viewInsets.bottom;
    bodyTrailingEdge = (topHeight+56)/windowHeight;
    floatingButtonWidth = windowWidth / 7;
  }

  Future<void> initApplicationDir() {
    return getApplicationDocumentsDirectory().then((f){
      applicationDir=f.path;
      return;
    });
  }

  String toJson() {
    return "{"
      "\"topHeight\": \"$topHeight\","
      "\"headHeight\": \"$headHeight\","
      "\"footHeight\": \"$footHeight\","
      "\"windowWidth\": \"$windowWidth\","
      "\"windowHeight\": \"$windowHeight\","
      "\"keybordHeight\": \"$keybordHeight\","
      "\"bodyTrailingEdge\": \"$bodyTrailingEdge\","
      "\"floatingButtonWidth\": \"$floatingButtonWidth\","
      "\"physics\": \"$physics\","
      "\"zeroEdgeInsets\": \"$zeroEdgeInsets\","
      "\"bgColor\": \"$bgColor\","
      "\"fgColor\": \"$fgColor\","
      "\"appNavBgColor\": \"$appNavBgColor\","
      "\"systemNavBgColor\": \"$systemNavBgColor\","
      "\"maskSystemNavBgColor\": \"$maskSystemNavBgColor\""
    "}";
  }

  @override
  String toString() => toJson();
}