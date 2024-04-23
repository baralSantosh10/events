import 'package:easy_debounce/easy_debounce.dart';
import 'package:event/core/repo/event/event_repo.dart';
import 'package:event/core/utils/constants/enums.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/event/event_model.dart';

class SearchEventController extends GetxController {
  RxList<EventModel> searchList = RxList();
  Rx<PageState> pageState = PageState.LOADING.obs;

  final searchController = TextEditingController();

  void onTextChange(String value) {
    EasyDebounce.debounce("Search-Product", const Duration(milliseconds: 500),
        () {
      searchEvents();
    });
  }

  void searchEvents() async {
    searchList.clear();
    EventRepo.searchEvents(
      keyword: searchController.text,
      onSuccess: (events) {
        if (events.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          searchList.addAll(events);
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
