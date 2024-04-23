class EventBookingRequestParams {
  String? eventId;
  String? qty;
  String? ticketType;
  String? totalPrice;

  String? refrenceId;

  //requirement of refrence id ( khalti )

  EventBookingRequestParams({
    this.eventId,
    this.qty,
    this.ticketType,
    this.totalPrice,
    required this.refrenceId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['qty'] = this.qty;
    data['ticket_type'] = this.ticketType;
    data['total_price'] = this.totalPrice;
        // data['reference_id'] = refrenceId;

    return data;
  }
}
