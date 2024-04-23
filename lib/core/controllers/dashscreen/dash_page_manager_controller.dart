// import 'package:chalchitra2/core/controllers/core_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core_controller.dart';

class DashboardPanelController extends GetxController {
  final CoreController coreController = Get.find();

  final PageController pageController = PageController();

  RxInt currentIndex = RxInt(0);

  void onPageTapped(int index) {
    // if (index == 2 && !coreController.isUserLoggedIn()) {
    //   currentIndex.value = index;

    //   pageController.jumpToPage(3);
    //   return;
    // } else {

    // if (index == 0 || index == 1 || index == 2 || index == 3) {
    //   currentIndex.value = index;
    //   pageController.jumpToPage(index);
    //   return;
    // }
    currentIndex.value = index;
    pageController.jumpToPage(index);
    return;
    // }
  }
}
