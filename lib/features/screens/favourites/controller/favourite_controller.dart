import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:event/core/widgets/custom/app_progress_dialog.dart';
import 'package:event/core/widgets/custom/app_snackbar.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  RxList<EventModel> favEventsLists = RxList();
  Rx<PageState> pageState = PageState.LOADING.obs;

  final coreController = Get.find<CoreController>();
  @override
  void onInit() {
    getFavourites();
    super.onInit();
  }

  void getFavourites() async {
    await EventRepo.getWishlistProducts(
      onSuccess: (favEventList) {
        favEventsLists.clear();

        if (favEventList.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          favEventsLists.addAll(favEventList);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  ProgressDialog loading = ProgressDialog();

  void removeFromWishList(int eventId) async {
    loading.show();
    await EventRepo.removeItem(
      productId: eventId,
      onSuccess: () {
        loading.hide();
        getFavourites();

        GearSnackBar.success(
            title: "Favourite",
            message: "Event succesfully removed from FavouriteList");
      },
      onError: (message) {
        loading.hide();
        GearSnackBar.error(title: "Favourite", message: message);
      },
    );
  }
}
