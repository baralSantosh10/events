import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:event/core/controllers/dashscreen/event/update_event_controller.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/utils/constants/icon_paths.dart';
import 'package:event/core/utils/helpers/image_helper.dart';
import 'package:event/core/utils/helpers/validators.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/common/network_imge.dart';
import 'package:event/core/widgets/common/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateEventScreen extends StatelessWidget {
  static const String routeName = "/update-evnt-screen";
  final c = Get.find<UpdateEventController>();
  UpdateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${c.event.value?.eventTitle ?? "Update Event"}"),
          actions: [
            IconButton(
                onPressed: () {
                  // print(c.pickedFile.value);
                  // print("${${Api.imageUpdateUrl} ${c.imageUrl}" }")
                  print("${Api.imageUpdateUrl}${c.imageUrl}");
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          // physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 100),
            child: Form(
              key: c.updateEventKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Event Name",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Event Name",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.checknameEmpty,
                    controller: c.eventNameController,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Event Date",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => PrimaryTextField(
                      hint: "Event Date",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      validator: Validators.checknameEmpty,
                      readOnly: true,
                      suffixIcon: c.isDobHasData.value == true
                          ? InkResponse(
                              onTap: () {
                                c.eventDateController.clear();
                                c.isDobHasData.value = false;
                              },
                              child: const Icon(
                                Icons.clear,
                                color: AppColors.primary,
                              ),
                            )
                          : const Icon(
                              Icons.calendar_month,
                              color: AppColors.primary,
                            ),
                      controller: c.eventDateController,
                      onTap: c.pickDate,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Event Time",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Event Time",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.checknameEmpty,
                    suffixIcon: const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.grey,
                    ),
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: Time(
                            hour: c.time.hour,
                            minute: c.time.minute,
                          ),
                          sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                          sunset: TimeOfDay(hour: 18, minute: 0), // optional
                          duskSpanInMinutes: 120, // optional
                          is24HrFormat: false,

                          onChange: (Time newTime) {
                            print('Selected time: $newTime');
                            String formattedTime =
                                '${newTime.hour}:${newTime.minute}';
                            c.eventTimeController.text = formattedTime;
                          },
                        ),
                      );
                    },
                    controller: c.eventTimeController,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   "Event Type",
                  //   style:
                  //       CustomTextStyles.f16W400(color: AppColors.blackColor),
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // PrimaryTextField(
                  //   hint: "Event Type",
                  //   textInputAction: TextInputAction.next,
                  //   textInputType: TextInputType.emailAddress,
                  //   readOnly: true,
                  //   validator: Validators.checknameEmpty,
                  //   controller: c.eventTypeController,
                  //   suffixIcon: const Icon(
                  //     Icons.keyboard_arrow_down_outlined,
                  //     color: Colors.grey,
                  //   ),
                  //   onTap: () {
                  //     // c.showVenueType();
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),

                  Text(
                    "Select Veneu",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Select Venue",
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      c.showVenueLocation();
                    },
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.checknameEmpty,
                    controller: c.eventVenueController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Obx(() {
                          final file = c.pickedFile.value;
                          if (file != null) {
                            return Image.file(
                              file,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            );
                          } else {
                            print("else hai ");
                            print("${Api.imageUpdateUrl}${c.imageUrl}");
                            return Obx(
                              () => SkyNetworkImage(
                                imageUrl: "${Api.imageUpdateUrl}${c.imageUrl}",
                                height: 100,
                                width: 100,
                              ),
                            );
                            // return Obx(() => Image.network(
                            //     "${Api.imageUpdateUrl}${c.imageUrl}"));
                          }
                        }),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: InkResponse(
                          onTap: () {
                            ImageHelper.pickImage(
                                imageSource: ImageSource.gallery,
                                onPickImage: (imageFile) {
                                  c.pickImage(imageFile);
                                });
                          },
                          child: SvgPicture.asset(
                            IconPath.camera,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "VIP seat price",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "VIP seat price",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    validator: Validators.checknameEmpty,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: c.eventVipPriceController,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Public seat price",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Public seat price",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    validator: Validators.checknameEmpty,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: c.eventPublicPriceController,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    "Description",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Description",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.checknameEmpty,
                    controller: c.eventDescriptionController,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    "Total VIP seats",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Total VIP seats",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: Validators.checkFieldEmpty,
                    controller: c.totalVipSeatsController,
                    onTap: () {
                      c.onCalculateTotalSeat();
                    },
                    onValueChange: (value) {
                      c.onCalculateTotalSeat();
                    },
                  ),

                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Total Public Seats",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Total Public Seats",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: Validators.checkFieldEmpty,
                    controller: c.totalPublicseatsController,
                    onTap: () {
                      c.onCalculateTotalSeat();
                    },
                    onValueChange: (value) {
                      c.onCalculateTotalSeat();
                    },
                  ),
                  Text(
                    "Total Seats",
                    style:
                        CustomTextStyles.f16W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  PrimaryTextField(
                    hint: "Total Seats",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: Validators.checkFieldEmpty,
                    readOnly: true,
                    controller: c.totalSeatsController,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryElevatedButton(
                    onPressed: () {
                      c.updateEvent();
                    },
                    title: "Update",
                  ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
