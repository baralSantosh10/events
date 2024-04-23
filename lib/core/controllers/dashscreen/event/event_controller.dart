import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxList<EventModel> eventList = RxList();
  Rx<PageState> pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    getAllEvents();

    // var args = Get.arguments;
    // if (args != null) {
    //   print("--------------------args=========${args}");
    //   event.value = args['event'];
    // }
    super.onInit();
  }

//   RxInt tappedIndex = RxInt(0);

//   RxString movieDateStore = RxString("");

  void getAllEvents() async {
    eventList.clear();
    EventRepo.getAllEvents(
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


}
