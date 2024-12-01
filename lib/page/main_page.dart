import 'package:stardeweather/easy/easy_scaffold.dart';
import 'package:stardeweather/i18n/translation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  final RxInt currentPageIndex = RxInt(0);
}

class MainPage extends GetView<MainController> {

  const MainPage({super.key});

  @override
  MainController get controller => Get.put<MainController>(MainController());

  @override
  Widget build(BuildContext context){
    return EasyScaffold(
      fixBody: Obx(()=>IndexedStack(
        index: controller.currentPageIndex.value,
        children: [
          Container(alignment: Alignment.center, child: const Text("aaa")),
          Container(alignment: Alignment.center, child: const Text("bbb")),
          Container(alignment: Alignment.center, child: const Text("ccc")),
          Container(alignment: Alignment.center, child: const Text("ddd")),
        ]
      )),
      fixBottomBar:Obx(()=>EasyScaffoldNavigationBar(
          backgroundColor: Colors.white,
          items: [
            EasyScaffoldNavigationBarItem(
              iconData: Icons.local_fire_department_outlined,
              iconColor: controller.currentPageIndex.value==0 ? Colors.red : Colors.black54,
              textColor: controller.currentPageIndex.value==0 ? Colors.red : Colors.black54,
              label: "Main:home".xtr,
              onTap: (context){
                controller.currentPageIndex.value = 0;
              },
            ),
            EasyScaffoldNavigationBarItem(
              iconData: CupertinoIcons.square_grid_2x2,
              iconColor: controller.currentPageIndex.value==1 ? Colors.red : Colors.black54,
              textColor: controller.currentPageIndex.value==1 ? Colors.red : Colors.black54,
              label: "Main:chapter".xtr,
              onTap: (context){
                controller.currentPageIndex.value = 1;
              },
            ),
            EasyScaffoldNavigationBarItem(
              iconData: CupertinoIcons.star,
              iconColor: controller.currentPageIndex.value==2 ? Colors.red : Colors.black54,
              textColor: controller.currentPageIndex.value==2 ? Colors.red : Colors.black54,
              label: "Main:library".xtr,
              onTap: (context){
                controller.currentPageIndex.value = 2;
              },
            ),
            // EasyScaffoldNavigationBarItem(
            //   iconData: CupertinoIcons.person,
            //   iconColor: controller.currentPageIndex.value==3 ? Colors.red : Colors.black54,
            //   textColor: controller.currentPageIndex.value==3 ? Colors.red : Colors.black54,
            //   label: "Main:me".xtr,
            //   onTap: (context){
            //     controller.currentPageIndex.value = 3;
            //   },
            // )
          ],
        )
      )
    );
  }
}

//   static const IconData icon_data_home    = IconData(0xe68e, fontFamily: 'iconfont');
//   static const IconData icon_data_mylib   = IconData(0xe610, fontFamily: 'iconfont');
//   static const IconData icon_data_weekly  = IconData(0xe705, fontFamily: 'iconfont');
//   static const IconData icon_data_me      = IconData(0xe66f, fontFamily: 'iconfont');
//   static const IconData icon_data_charge  = IconData(0xe659, fontFamily: 'iconfont');
//   static const IconData icon_data_column  = IconData(0xe653, fontFamily: 'iconfont');
//   static const IconData icon_data_loading = IconData(0xe63e, fontFamily: 'iconfont');