import 'package:event/core/controllers/dashscreen/event/event_detail_controller.dart';
import 'package:event/core/model/event/event_booking_request_params.dart';
import 'package:event/core/utils/constants/colors.dart';
import 'package:event/core/widgets/common/button.dart';
import 'package:event/core/widgets/common/custom_text_style.dart';
import 'package:event/core/widgets/custom/app_radio_button.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class BookingEventBottomSheet extends StatelessWidget {
  final c = Get.find<EventDetailController>();
  BookingEventBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Book ${c.event.value?.eventTitle} ",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Ticket Type",
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => SkyRadioButton(
                  value: "Public",
                  groupVlaue: c.selectedTicketType.value,
                  onTap: c.changeTicketType,
                  title: "Public",
                ),
              ),
              Obx(
                () => SkyRadioButton(
                  value: "VIP",
                  groupVlaue: c.selectedTicketType.value,
                  onTap: c.changeTicketType,
                  title: "VIP",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                "Ticekt Price: ${c.price.value} ",
                style: CustomTextStyles.f16W600(color: AppColors.blackColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: true,
            child: Container(
              // height: 130,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 8,
                      spreadRadius: 2,
                      color: AppColors.lightGrey)
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //   if (c.itemQuantity.value > 1) {
                            //     c.itemQuantity.value--;
                            //   }
                            // },
                            onTap: () {
                              c.decrementQuantity();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              // child: SvgPicture.asset(
                              //   IconPath.minus,
                              //   height: 24,
                              //   width: 24,
                              // ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(),
                                    color: Colors.grey[100]),
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: AppColors.blackColor, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minHeight: 16, minWidth: 16),
                                  child: Center(
                                    child: Text(
                                      c.itemQuantity.value.toString(),
                                      style: CustomTextStyles.f16W600(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              c.incrementQuantity();
                            },
                            // onTap: () {
                            //   c.itemQuantity.value++;
                            // },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              // child: SvgPicture.asset(
                              //   IconPath.plus,
                              //   height: 24,
                              //   width: 24,
                              // ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(),
                                    color: Colors.grey[100]),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    flex: 1,
                    child: PrimaryElevatedButton(
                      // width: 20,
                      onPressed: () {
                        // c.bookEvent();

                        KhaltiScope.of(context).pay(
                            config: PaymentConfig(
                              // amount: c.price.value.toInt(),
                              amount: c.price.value.toInt() * 100,

                              productIdentity: 'event-booking-cost',
                              productName: 'event-ticket-price',
                            ),
                            preferences: [
                              PaymentPreference.khalti,
                              // PaymentPreference.connectIPS,
                            ],
                            onSuccess: (PaymentSuccessModel su) {
                              c.eventBookingRequestParamsModel =
                                  EventBookingRequestParams(
                                // movieShowId: int.parse(
                                //   (c.movieShow.value?.id)
                                //       .toString(),
                                // ),
                                // refrenceId: su.idx,
                                // totalTicketPrice: total,
                                // selectedSeats: c.bookedSeatList,

                                eventId: c.event.value!.id!.toString(),
                                qty: c.itemQuantity.value.toString(),
                                ticketType: c.selectedTicketType.value,
                                totalPrice: c.price.value.toString(),
                                refrenceId: su.idx,
                              );
                              c.bookEvent(c.eventBookingRequestParamsModel);
                              Get.back();
                              GearSnackBar.success(
                                  title: "Payment",
                                  message: "Payment Successful");
                            },
                            onFailure: (fa) {
                              Get.back();
                              GearSnackBar.error(
                                  title: "Failed", message: "Error Failed");
                            },
                            onCancel: () {
                              Get.back();
                              ("Payment cancelled!!",);
                            });
                      },
                      title: "Book Now",
                      color: AppColors.primary,
                      height: 40,
                      // width: 50,
                      textStyle: CustomTextStyles.f14W500(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
