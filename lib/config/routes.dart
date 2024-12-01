
import 'package:stardeweather/page/main_page.dart';
import 'package:get/get.dart';

class Routes {

/*
  Future<dynamic>? futureResult = Get.toNamed("/page/editNote", arguments: {"note": notesRx[index]});
    if (futureResult!=null) {
      futureResult.then((result){
        if (result!=null && result["action"]=="update" && result["data"]!=null) {
          notesRx[index] = result["data"];
        }
        refreshView();
      });
    }
 */
  static final getPages = [
    // page
    GetPage(name: '/page/main',    page: () => const MainPage()),
  ];
}
