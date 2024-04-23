import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:event/core/model/category_model.dart';
import 'package:event/core/model/event/add_event_request_model.dart';
import 'package:event/core/model/event/event_model.dart';
import 'package:event/core/model/location_model.dart';
import 'package:event/core/utils/constants/apis.dart';
import 'package:event/core/utils/constants/messages.dart';
import 'package:event/core/utils/helpers/app_requests.dart';
import 'package:event/core/utils/helpers/log_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/event/event_booking_request_params.dart';

class EventRepo {
  static Future<void> getCategories({
    required Function(List<CategoryModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getCategories;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var categories = categoriesFromJson(data['data']);
        onSuccess(categories);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getCategories, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> becomeOrganizer({
    required int userId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.becomeOrganizer;

      var body = {
        "id": userId,
      };

      http.Response response = await AppRequest.post(url, body: body);

      dynamic data = json.decode(response.body);

      print('--------------------$data');

      if (data['status']) {
        var msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.becomeOrganizer, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> addEvent({
    required AddEventRequestParams? addEventParams,
    required File? file,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeEvent;
      List<http.MultipartFile> images = [];
      if (file != null) {
        images = [
          http.MultipartFile.fromBytes(
            "thumbnail",
            await file.readAsBytes(),
            filename: "image",
            contentType: MediaType("image", "*"),
          )
        ];
      }

      http.StreamedResponse response = await AppRequest.multiPart(
        url: url,
        files: images,
        // fields: json.encode(menuRequestParams?.toJson()),
        fields: addEventParams?.toJson(),
        // fields: encodedParams,
      );

      print("----------------${response}");

      dynamic data = json.decode(await response.stream.bytesToString());

      print("--------------response-------------$data");

      if (data['status']) {
        var msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeEvent, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getAllEvents({
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAllEvents;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var events = eventsFromJson(data['data']);
        onSuccess(events);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getAllEvents, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getEventDetails({
    required int eventId,
    required Function(EventModel event) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = (Api.eventDetails.replaceAll("#id#", eventId.toString()));

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var event = EventModel.fromJson(data['data']);
        onSuccess(event);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.eventDetails, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateEvent({
    required eventId,
    required AddEventRequestParams? addEventParams,
    required File? file,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.updateEvent}/$eventId";
      List<http.MultipartFile> images = [];
      if (file != null) {
        images = [
          http.MultipartFile.fromBytes(
            "thumbnail",
            await file.readAsBytes(),
            filename: "image",
            contentType: MediaType("image", "*"),
          )
        ];
      }

      http.StreamedResponse response = await AppRequest.multiPart(
        url: url,
        files: images,
        // fields: json.encode(menuRequestParams?.toJson()),
        fields: addEventParams?.toJson(),
        // fields: encodedParams,
      );

      print("----------------${response}");

      dynamic data = json.decode(await response.stream.bytesToString());

      print("--------------response-------------$data");

      if (data['status']) {
        var msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error("${Api.updateEvent}/$eventId", error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getPopularEvents({
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getallevent;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var events = eventsFromJson(data['data']);
        onSuccess(events);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getallevent, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getAllMyEvents({
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.myEvents;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var events = eventsFromJson(data['data']);
        onSuccess(events);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.myEvents, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getLocations({
    required Function(List<LocationModel> venues) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getallvenue;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var venues = locationsFromJson(data['data']);
        onSuccess(venues);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getallvenue, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> bookEvent({
    // required String eventId,
    // required String quantity,
    // required String ticketType,
    // required String price,
    required EventBookingRequestParams? eventBookingRequestParams,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.bookEvent;

      // var body = {
      //   "event_id": eventId,
      //   "qty": quantity,
      //   "ticket_type": ticketType,
      //   "total_price": price,
      // };
      var body = eventBookingRequestParams?.toJson();

      http.Response response = await AppRequest.post(url, body: body);

      dynamic data = json.decode(response.body);

      print('--------------------$data');

      if (data['status']) {
        var msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.bookEvent, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> searchEvents({
    String? keyword,
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      // String url = Api.searchEvents;
      String url =
          (Api.searchEvents.replaceAll("#keyword#", keyword.toString()));

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var events = eventsFromJson(data['data']);
        onSuccess(events);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.searchEvents, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> bookedEvents({
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.bookedEvents;

      http.Response response = await AppRequest.get(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        var events = eventsFromJson(data['data']);
        onSuccess(events);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.bookedEvents, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteEvent({
    required int eventId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.deleteEvents}/$eventId";

      http.Response response = await AppRequest.post(
        url,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        var msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.deleteEvents, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> addToFavourite({
    required int eventId,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      // String url = "${Api.addFavourite}/$eventId";
      String url = "${Api.addFavourite}";

      var body = {
        "event_id": eventId,
      };

      http.Response response = await AppRequest.post(
        url,
        body: body,
      );

      dynamic data = json.decode(response.body);

      if (data['status']) {
        // var msg = data['message'];
        // onSuccess(msg);
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.addFavourite, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getWishlistProducts({
    // String? nextPageUrl,
    required Function(List<EventModel> favEventList) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getFavList;
      http.Response response = await AppRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data["status"]) {
        var favEventList = eventsFromJson(data['data']);
        print("------------------fav events -----${favEventList}");
        onSuccess(favEventList);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getFavList, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> removeItem({
    required num productId,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      // String url = "${Api.deleteFav}?id=$productId";
      String url = Api.deleteFav;

      var body = {
        "event_id": productId,
      };

      http.Response response = await AppRequest.post(url, body: body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.deleteFav, error: e, stackTrace: s);
    }
  }

  static Future<void> check({
    required num eventId,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.checkWishListUrl}?id=$eventId";

      http.Response response = await AppRequest.get(url);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error("${Api.checkWishListUrl}?id=$eventId",
          error: e, stackTrace: s);
    }
  }

  static Future<void> getItemsByCategoryId({
    required String categoryId,
    required Function(List<EventModel> events) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.getEventById}?id=$categoryId";

      http.Response response = await AppRequest.get(
        url,
      );
      print("---------------response$response}");
      var data = json.decode(response.body);
      print(data);
      if (data["status"]) {
        var items = eventsFromJson(data['data']);

        print("---cate${items}");
        onSuccess(items);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getEventById, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
