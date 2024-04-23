class AddEventRequestParams {
  String? eventTitle;
  String? description;
  String? eventDate;
  String? eventTime;
  // String? category;
  int? category;

  String? location;
  // String? thumbnail;
  String? totalSeats;
  String? totalVipSeats;
  String? totalPublicSeats;
  String? vipSeatsPrice;
  String? publicSeatsPrice;

  AddEventRequestParams(
      {this.eventTitle,
      this.description,
      this.eventDate,
      this.eventTime,
      this.location,
      // this.thumbnail,
      this.totalSeats,
      this.totalVipSeats,
      this.totalPublicSeats,
      this.vipSeatsPrice,
      this.category,
      this.publicSeatsPrice});

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['event_title'] = this.eventTitle.toString();
    data['description'] = this.description.toString();
    data['event_date'] = this.eventDate.toString();
    data['event_time'] = this.eventTime.toString();
    data['location'] = this.location.toString();
    // data['thumbnail'] = this.thumbnail;
    data['total_seats'] = this.totalSeats.toString();
    data['total_vip_seats'] = this.totalVipSeats.toString();
    data['total_public_seats'] = this.totalPublicSeats.toString();
    data['vip_seats_price'] = this.vipSeatsPrice.toString();
    data['public_seats_price'] = this.publicSeatsPrice.toString();
    data['category'] = this.category.toString();

    return data;
  }
}
