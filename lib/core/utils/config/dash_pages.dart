import 'package:event/core/controllers/dashscreen/event/event_add_controller.dart';
import 'package:event/core/controllers/dashscreen/event/event_controller.dart';
import 'package:event/core/controllers/dashscreen/event/event_detail_controller.dart';
import 'package:event/core/controllers/dashscreen/event/update_event_controller.dart';
import 'package:event/core/controllers/dashscreen/my_booked_events/my_booked_events_controller.dart';
import 'package:event/core/controllers/dashscreen/profile/profile_controller.dart';
import 'package:event/core/controllers/dashscreen/profile/update_controller.dart';
import 'package:event/core/controllers/dashscreen/search_event/search_event_controller.dart';
import 'package:event/features/screens/add_event/update_event_screen.dart';
import 'package:event/features/screens/booked_events/my_booked_events.dart';
import 'package:event/features/screens/events/event_detail_screen.dart';
import 'package:event/features/screens/favourites/controller/favourite_controller.dart';
import 'package:event/features/screens/home/search_event_screen.dart';
import 'package:event/features/screens/profile/change_password_screen.dart';
import 'package:event/features/screens/profile/update_profile_screen.dart';
import 'package:get/get.dart';

import '../../../features/screens/dashscreen/dashboard_panel.dart';
import '../../../features/screens/favourites/presentation/favourites_screen.dart';
import '../../../features/screens/my_events/controller/my_event_controller.dart';
import '../../../features/screens/my_events/presentation/my_events_screen.dart';
import '../../controllers/dashscreen/dash_page_manager_controller.dart';
import '../../controllers/dashscreen/home_screen_controller.dart';

final List<GetPage> dashScreenPages = <GetPage>[
  GetPage(
    name: DashPageManager.routeName,
    page: () => DashPageManager(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => DashboardPanelController());
        Get.lazyPut(() => HomeScreenController());
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => EventAddController());
        Get.lazyPut(() => EventsController());
      },
    ),
  ),

  GetPage(
    name: EventDetailScreen.routeName,
    page: () => EventDetailScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => EventDetailController());
      },
    ),
  ),

  GetPage(
    name: UpdateEventScreen.routeName,
    page: () => UpdateEventScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => UpdateEventController());
      },
    ),
  ),

  GetPage(
    name: UpdateProfileScreen.routeName,
    page: () => UpdateProfileScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => UpdateProfileController());
      },
    ),
  ),

  GetPage(
    name: FavouritesScreen.routeName,
    page: () => FavouritesScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => FavouriteController());
      },
    ),
  ),

  GetPage(
    name: MyEventsScreen.routeName,
    page: () => MyEventsScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => myEventController());
      },
    ),
  ),

  GetPage(
    name: ChangePassword.routeName,
    page: () => ChangePassword(),
    binding: BindingsBuilder(
      () {
        // Get.lazyPut(() => myEventController());
      },
    ),
  ),

  GetPage(
    name: MyBookedEventsScreen.routeName,
    page: () => MyBookedEventsScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => MyBookedEventController());
      },
    ),
  ),

  GetPage(
    name: SearchEventScreen.routeName,
    page: () => SearchEventScreen(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => SearchEventController());
      },
    ),
  ),
//   // GetPage(
//   //   name: GearListsPage.routeName,
//   //   page: () => GearListsPage(),
//   //   binding: BindingsBuilder(
//   //     () {
//   //       Get.lazyPut(() => GearListController());
//   //     },
//   //   ),
//   // ),
  // GetPage(
  //   name: ProfileScreen.routeName,
  //   page: () => ProfileScreen(),
  //   binding: BindingsBuilder(
  //     () {
  //       Get.lazyPut(() => ProfileController());
  //     },
  //   ),
  // ),
//   // GetPage(
//   //   name: ActivityPage.routeName,
//   //   page: () => ActivityPage(),
//   //   binding: BindingsBuilder(
//   //     () {
//   //       Get.lazyPut(() => ActivityController());
//   //     },
//   //   ),
//   // ),
//   // GetPage(
//   //   name: ChangePasswordPage.routeName,
//   //   page: () => ChangePasswordPage(),
//   //   binding: BindingsBuilder(
//   //     () {
//   //       Get.lazyPut(() => ChangePasswordController());
//   //     },
//   //   ),
//   // ),
//   // GetPage(
//   //   name: AdventureDetailPage.routeName,
//   //   page: () => AdventureDetailPage(),
//   //   binding: BindingsBuilder(
//   //     () {
//   //       Get.lazyPut(() => AdventureDetailController());
//   //     },
//   //   ),
//   // ),
];
