import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class myEventController extends GetxController {
  RxList<EventModel> eventList = RxList();
  Rx<PageState> pageState = PageState.LOADING.obs;
  ProgressDialog loading = ProgressDialog();
  RxBool showPass = RxBool(false);

  @override
  void onInit() {
    getMyEvents();

    // var args = Get.arguments;
    // if (args != null) {
    //   print("--------------------args=========${args}");
    //   event.value = args['event'];
    // }
    super.onInit();
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    getMyEvents();
    refreshController.refreshCompleted();
  }

  void getMyEvents() async {
    eventList.clear();
    EventRepo.getAllMyEvents(
      onSuccess: (events) {
        if (events.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          eventList.addAll(events);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void deleteProduct(int eventId) async {
    loading.show();
    await EventRepo.deleteEvent(
        eventId: eventId,
        onSuccess: (message) {
          loading.hide();
          getMyEvents();
          GearSnackBar.success(
              title: "Event", message: "Event has been deleted succesfully");
        },
        onError: (message) {
          loading.hide();
          GearSnackBar.error(title: "Product", message: message);
        });
  }
}
