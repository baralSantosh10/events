import 'package:event/core/controllers/dashscreen/profile/profile_controller.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/features/screens/booked_events/my_booked_events.dart';
import 'package:event/features/screens/favourites/presentation/favourites_screen.dart';
import 'package:event/features/screens/my_events/presentation/my_events_screen.dart';
import 'package:event/features/screens/profile/change_password_screen.dart';
import 'package:event/features/screens/profile/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/common_alert.dart';
import '../../../core/widgets/common/network_imge.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile-page/";
  final c = Get.find<ProfileController>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(c.coreController.currentUser.value?.status);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   decoration: const BoxDecoration(
          //     color: AppColors.whiteColor,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(255, 204, 203, 203),
          //         blurRadius: 2.0,
          //         spreadRadius: 1,
          //         offset: Offset(
          //           0,
          //           3,
          //         ),
          //       )
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       //TODO logo
          //       Text(
          //         "Profile",
          //         style: CustomTextStyles.f16W600(),
          //       ),
          //       const Icon(
          //         Icons.search,
          //         color: AppColors.primary,
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const SkyNetworkImage(
                    imageUrl: "",
                    width: 60,
                    height: 60,
                    boxFit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => RichText(
                            text: TextSpan(
                              text: 'Name:  ',
                              style:
                                  CustomTextStyles.f16W600(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text:
                                      '${c.coreController.currentUser.value?.name ?? ""}'
                                          .toUpperCase(),
                                  style: CustomTextStyles.f16W600(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => RichText(
                            text: TextSpan(
                              text: 'Email:  ',
                              style:
                                  CustomTextStyles.f16W600(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text:
                                      '${c.coreController.currentUser.value?.email ?? ""}',
                                  style: CustomTextStyles.f16W600(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => RichText(
                            text: TextSpan(
                              text: 'Gender:  ',
                              style:
                                  CustomTextStyles.f16W600(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text:
                                      '${c.coreController.currentUser.value?.gender == "1" ? "Male" : "Female"}',
                                  style: CustomTextStyles.f16W600(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => RichText(
                            text: TextSpan(
                              text: 'Role:  ',
                              style:
                                  CustomTextStyles.f16W600(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text:
                                      '${c.coreController.currentUser.value?.status == "1" ? "Organizer" : "User"}',
                                  style: CustomTextStyles.f16W600(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProfileTiles(
                  onTap: () {
                    Get.toNamed(UpdateProfileScreen.routeName);
                  },
                  iconUrl: IconPath.user,
                  title: "Update Profile",
                ),
                const SizedBox(
                  height: 10,
                ),
                // ProfileTiles(
                //   onTap: () {
                //     Get.toNamed(RecentOrdersScreen.routeName);
                //   },
                //   iconUrl: IconPath.recentOrder,
                //   title: "Recent Orders",
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                if (c.coreController.currentUser.value?.status == "1")
                  ProfileTiles(
                    onTap: () {
                      Get.toNamed(MyEventsScreen.routeName);
                    },
                    iconUrl: IconPath.recentOrder,
                    title: "My Events",
                  ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTiles(
                  onTap: () {},
                  iconUrl: IconPath.history,
                  title: "History",
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTiles(
                  onTap: () {
                    Get.toNamed(MyBookedEventsScreen.routeName);
                  },
                  iconUrl: IconPath.plus,
                  title: "Booked Events",
                ),
                const SizedBox(
                  height: 10,
                ),
                // ignore: unrelated_type_equality_checks
                if (c.coreController.currentUser.value?.status !=
                    "1") //1 means organizer
                  ProfileTiles(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomAlertDialog(
                              title: "You want to become an organizer ?",
                              message:
                                  "You will be logged out for this action.",
                              onConfirm: () {
                                c.becomeBoss();
                              },
                              confirmText: "Yes",
                            );
                          });
                    },
                    iconUrl: IconPath.organizer,
                    title: "Become an Organizer",
                  ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTiles(
                  onTap: () {
                    Get.toNamed(FavouritesScreen.routeName);
                  },
                  iconUrl: IconPath.fav,
                  title: "Favourite",
                ),
                Divider(
                  height: 10,
                  color: AppColors.lightGrey,
                  indent: 10,
                  endIndent: 10,
                ),
                ProfileTiles(
                  onTap: () {
                    // c.openBottomSheetChangePW();
                    Get.toNamed(ChangePassword.routeName);
                  },
                  title: "Change password",
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTiles(
                  title: "Contact",
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileTiles(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return CustomAlertDialog(
                            // title: "Logout Confirmation",
                            message: "Are you sure to logout?",
                            onConfirm: () {
                              c.coreController.logOut();
                            },
                            confirmText: "Logout",
                          );
                        });
                  },
                  title: "Log out",
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class ProfileTiles extends StatelessWidget {
  final String? iconUrl;
  final String title;
  final Function() onTap;

  const ProfileTiles({
    super.key,
    this.iconUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: SvgPicture.asset(iconUrl ?? ""),
      title: Text(
        title,
        style: CustomTextStyles.f16W400(),
      ),
      trailing: SvgPicture.asset(IconPath.rightArrow),
    );
  }
}
