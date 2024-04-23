// import 'package:chalchitra2/core/model/date_model.dart';
// import 'package:chalchitra2/core/model/movie_model.dart';
// import 'package:chalchitra2/core/repo/movie_repo.dart';
// import 'package:chalchitra2/core/utils/constants/enums.dart';
// import 'package:chalchitra2/core/utils/helpers/log_helper.dart';
// import 'package:get/get.dart';

import 'package:event/core/controllers/core_controller.dart';
import 'package:event/core/model/category_model.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxList<CategoryModel> categoryList = RxList();
  RxList<EventModel> eventList = RxList();

  Rx<PageState> pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    getAllCategories();
    getAllEvents();

    super.onInit();
  }

// //   RxInt tappedIndex = RxInt(0);

// //   RxString movieDateStore = RxString("");

  RxInt selectedIndex = (-1).obs;


  void getAllCategories() async {
    categoryList.clear();
    EventRepo.getCategories(
      onSuccess: (categories) {
        if (categories.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          categoryList.addAll(categories);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }


  void getProductsByCategoryId(int categoryId) async {
    eventList.clear();
    await EventRepo.getItemsByCategoryId(
      categoryId: categoryId.toString(),
      onSuccess: (products) {
        if (products.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          eventList.addAll(products);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

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
