import 'package:event/core/utils/config/pages.dart';
import 'package:event/core/utils/constants/theme.dart';
import 'package:event/features/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'core/controllers/core_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put(CoreController());
  runApp(Event()
      // DevicePreview(
      // enabled: !kReleaseMode,
      // builder: (context) => MyApp(), // Wrap your app
      // ),

      );
}

class Event extends StatelessWidget {
  // final coreController = Get.find<CoreController>();

  Event({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      // publicKey: "test_public_key_307850aa01dd432799359e427571f6a7",
      publicKey: "test_public_key_58748be8be1e4b71b3b76aa04a6df48e",
      builder: (context, navigatorKey) {
        return GetMaterialApp(
          title: "Event",
          useInheritedMediaQuery: true,
          theme: CustomTheme.basicTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          getPages: getPages,
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            // Locale('ne', 'np'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
          fallbackLocale: const Locale('en'),

          // locale: DevicePreview.locale(context),
          locale: const Locale('en'),
          themeMode: ThemeMode.light,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                // Assuming primary color is used for Khalti button color
                primaryColor: Theme.of(context).colorScheme.primary,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}


// GetMaterialApp(
//       theme: CustomTheme.basicTheme(),
//       debugShowCheckedModeBanner: false,
//       // initialRoute: SplashScreen.routeName,
//       initialRoute: DashPageManager.routeName,
//       getPages: getPages,
//     );