List<LocationModel> locationsFromJson(List<dynamic> locationsJson) =>
    List<LocationModel>.from(locationsJson
        .map((locationJson) => LocationModel.fromJson(locationJson)));

class LocationModel {
  int? id;
  String? title;

  LocationModel({this.id, this.title});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
