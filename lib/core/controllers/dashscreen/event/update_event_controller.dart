import 'dart:io';

import 'package:event/core/model/event/add_event_request_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/helpers/xosial_date_piceker.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:event/features/screens/add_event/show_venue_location_bottom_sheet.dart';
import 'package:event/features/screens/my_events/controller/my_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/event/event_model.dart';

class UpdateEventController extends GetxController {
  GlobalKey<FormState> updateEventKey = GlobalKey<FormState>();
  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();

  final eventTimeController = TextEditingController();

  final eventTypeController = TextEditingController();

  final eventGuestsNoController = TextEditingController();

  final eventVenueController = TextEditingController();

  final eventVipPriceController = TextEditingController();
  final eventPublicPriceController = TextEditingController();

  final totalSeatsController = TextEditingController();

  final totalVipSeatsController = TextEditingController();

  final totalPublicseatsController = TextEditingController();

  final eventDescriptionController = TextEditingController();

  RxBool isDobHasData = RxBool(false);
  TimeOfDay time = TimeOfDay.now();

  Rxn<EventModel> event = Rxn();
  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      event.value = args['event'];
    }
    onLoading();
    super.onInit();
  }

  RxString imageUrl = RxString("");
  onLoading() {
    eventNameController.text = event.value?.eventTitle ?? "";
    eventDateController.text = event.value?.eventDate ?? "";
    eventTimeController.text = event.value?.eventTime ?? "";
    // eventTypeController.text = event.value?.
    eventVenueController.text = event.value?.location ?? "";
    eventVipPriceController.text = event.value?.vipSeatsPrice ?? "";
    eventPublicPriceController.text = event.value?.publicSeatsPrice ?? "";
    eventDescriptionController.text = event.value?.description ?? "";
    totalSeatsController.text = event.value?.totalSeats ?? "";
    totalVipSeatsController.text = event.value?.totalVipSeats ?? "";
    totalPublicseatsController.text = event.value?.totalPublicSeats ?? "";

    // String? thumbnail = event.value?.thumbnail;
    // if (thumbnail != null) {
    //   // Concatenate the base URL with the thumbnail path
    //   String imageUrlWithThumbnail = '${Api.imageUpdateUrl}$thumbnail';
    //   // Assign the constructed URL to pickedFile.value
    //   pickedFile.value = File(imageUrlWithThumbnail);
    // }
    // ------------------

    // pickedFile.value = event.value?.thumbnail ?? "";

    // final String? thumbnail = event.value?.thumbnail;
    // if (thumbnail != null) {
    //   // Construct full URL for the thumbnail
    //   final String fullUrl = Api.imageUpdateUrl + thumbnail;
    //   // Assign the full URL to pickedFile.value
    //   pickedFile.value = File(fullUrl);
    // }

    // --------------
    imageUrl.value = event.value?.thumbnail ?? "";
  }

  onCalculateTotalSeat() {
    var totalSeat = int.parse(totalPublicseatsController.text) +
        int.parse(totalVipSeatsController.text);

    totalSeatsController.text = totalSeat.toString();
  }

  void pickDate() {
    XosialDatePicker.pickDate(
      minDate: DateTime.now(),
      initialDate: DateTime.now(),
      maxDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      onDone: (date) {
        isDobHasData.value = true;
        eventDateController.text = date.toString().split(" ")[0];
      },
    );
  }

  showVenueLocation() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: VenueLocationBottomSheet(
            onSelectVenue: (venueType) {
              eventVenueController.text = venueType;
            },
          ),
        );
      },
    );
  }

  final Rx<File?> pickedFile = Rx<File?>(null);

  // Your other controller code...

  Future<void> pickImage(XFile imageFile) async {
    pickedFile.value = File(imageFile.path);
  }

  void clearVariables() {
    eventNameController.text = '';
    eventDateController.text = '';
    eventTimeController.text = '';
    eventTypeController.text = '';
    pickedFile.value = null;
    eventVenueController.clear();
    eventVipPriceController.text = '';
    totalSeatsController.text = '';
    eventPublicPriceController.text = '';
    eventDescriptionController.text = '';
    totalVipSeatsController.text = '';
    totalPublicseatsController.text = '';
  }

  ProgressDialog loading = ProgressDialog();

  Future<void> updateEvent() async {
    loading.show();
    AddEventRequestParams addEventRequestParams = AddEventRequestParams(
      eventTitle: eventNameController.text,
      eventDate: eventDateController.text,
      eventTime: eventTimeController.text,
      // category: int.parse(categoryModel.value!.id!.toString()),
      // thumbnail: pickedFile.toString(),
      location: eventVenueController.text,
      vipSeatsPrice: eventVipPriceController.text,
      totalSeats: totalSeatsController.text,
      publicSeatsPrice: eventPublicPriceController.text,
      description: eventDescriptionController.text,
      totalVipSeats: totalVipSeatsController.text,
      totalPublicSeats: totalPublicseatsController.text,
    );
    await EventRepo.updateEvent(
        eventId: event.value!.id!,
        addEventParams: addEventRequestParams,
        file: pickedFile.value,
        onSuccess: (message) {
          loading.hide();
          // Get.offAllNamed(DashPageManager.routeName);
          // Get.put(DashboardPanelController()).currentIndex.value =
          //     0; //TODO implementation
          clearVariables();
          Get.find<myEventController>().getMyEvents();
          Get.back();
          GearSnackBar.success(
              title: "Update Event Success",
              message: "Event Updated successfully");
        },
        onError: (message) {
          loading.hide();
          GearSnackBar.error(title: "Update Failed", message: message);
        });
  }
}
