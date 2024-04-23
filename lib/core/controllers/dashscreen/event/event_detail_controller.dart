import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/model/event/event_booking_request_params.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/messages.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:event/features/screens/events/event_booking_bottom_sheet.dart';
import 'package:event/features/screens/events/event_detail_screen.dart';
import 'package:event/features/screens/favourites/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailController extends GetxController {
  final coreController = Get.find<CoreController>();
  Rxn<EventModel> event = Rxn();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      event.value = args['event'];
    }
    super.onInit();
  }

  void getEventDetail() async {
    print(event.value?.id);
    if (event.value?.id != null) {
      EventRepo.getEventDetails(
        eventId: event.value!.id!,
        onSuccess: (event) {
          this.event.value = event;

          print("-----------------------${event}");
        },
        onError: (message) {
          LogHelper.error(message);
        },
      );
    } else {
      GearSnackBar.error(
          title: "Error Occurred",
          message: "Something went wrong while fetching detail page");
    }
  }

  openBookingBootomSheet() {
    price.value = int.parse(event.value?.publicSeatsPrice ?? '0');
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BookingEventBottomSheet(
              // onSelectVenue: (venueType) {
              //   eventVenueController.text = venueType;
              // },
              ),
        );
      },
    );
  }

  RxInt itemQuantity = RxInt(1);

  RxInt price = RxInt(0);

  RxString selectedTicketType = RxString("Public");

  void incrementQuantity() {
    itemQuantity.value++;
    calculatePrice();
  }

  void decrementQuantity() {
    if (itemQuantity.value > 1) {
      itemQuantity.value--;
      calculatePrice();
    }
  }

  void changeTicketType(String? ticketType) {
    selectedTicketType.value = ticketType ?? "Public";
    calculatePrice();
  }

  void calculatePrice() {
    if (selectedTicketType.value == "Public") {
      price.value =
          int.parse(event.value?.publicSeatsPrice ?? '0') * itemQuantity.value;
    } else {
      price.value =
          int.parse(event.value?.vipSeatsPrice ?? '0') * itemQuantity.value;
    }
  }

  ProgressDialog loading = ProgressDialog();
  EventBookingRequestParams? eventBookingRequestParamsModel;
  Future<void> bookEvent(
      EventBookingRequestParams? eventBookingRequestParams) async {
    loading.show();
    await EventRepo.bookEvent(
        eventBookingRequestParams: eventBookingRequestParams,
        onSuccess: (message) {
          loading.hide();
          Get.offNamed(EventDetailScreen.routeName);
          GearSnackBar.success(title: "Organizer", message: message);
        },
        onError: (message) {
          loading.hide();
          GearSnackBar.error(title: "Organizer", message: message);
        });
  }

  RxBool isLoading = RxBool(false);
  RxBool isFav = RxBool(false);
  RxBool isLoadingFav = RxBool(false);

  void checkFav() async {
    isLoadingFav.value = true;
    await EventRepo.check(
      eventId: event.value!.id!,
      onSuccess: () {
        isFav.value = true;
        isLoadingFav.value = false;
      },
      onError: (message) {
        isFav.value = false;
        isLoadingFav.value = false;
      },
    );
  }

  void toggleFav() {
    if (!coreController.isUserLoggedIn()) {
      GearSnackBar.info(
          message: Messages.unauthorizedMessage, title: "Unauthorized");
      return;
    }
    if (isLoadingFav.value) return;
    if (isFav.value) {
      removeFromWishList();
    } else {
      addToWishList();
    }
  }

  void addToWishList() async {
    isLoadingFav.value = true;
    await EventRepo.addToFavourite(
      eventId: event.value!.id!,
      onSuccess: () {
        isLoadingFav.value = false;
        isFav.value = true;
        GearSnackBar.success(
            title: "Favourite",
            message: "Event succesfully added to Favourites");

        if (Get.isRegistered<FavouriteController>()) {
          Get.find<FavouriteController>().getFavourites();
        }
      },
      onError: (message) {
        isLoadingFav.value;
        GearSnackBar.error(title: "Favourite", message: message);
      },
    );
  }

  void removeFromWishList() async {
    isLoadingFav.value = true;
    await EventRepo.removeItem(
      productId: event.value!.id!,
      onSuccess: () {
        isLoadingFav.value = false;
        isFav.value = false;

        GearSnackBar.success(
            title: "Favourite",
            message: "Event succesfully removed from FavouriteList");
        if (Get.isRegistered<FavouriteController>()) {
          Get.find<FavouriteController>().getFavourites();
        }
      },
      onError: (message) {
        isLoadingFav.value;
        GearSnackBar.error(title: "Favourite", message: message);
      },
    );
  }
}
