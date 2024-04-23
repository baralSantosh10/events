// import 'package:chalchitra2/core/controllers/splash_controller.dart';
// import 'package:chalchitra2/core/utils/config/auth_pages.dart';
// import 'package:chalchitra2/core/utils/config/dash_pages.dart';
// import 'package:chalchitra2/features/screens/splash_screen.dart';
// import 'package:get/get.dart';

import 'package:event/core/utils/config/dash_pages.dart';
import 'package:get/get.dart';

import '../../../features/screens/splash/splash_screen.dart';
import '../../controllers/splash_controller.dart';
import 'auth_pages.dart';

final List<GetPage> getPages = <GetPage>[
  ...authPages,
  ...dashScreenPages,
// //   GetPage(name: FirstPage.routeName, page: () => const FirstPage()),
  GetPage(
      name: SplashScreen.routeName,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      })),

  
];
