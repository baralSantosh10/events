class Api {
  static final String baseUrl = "http://eventease.com";

  static final String imageUrl = "$baseUrl/";
  static final String imageUpdateUrl = "$baseUrl";

  static const String prefix = "/api";
  static const String auth = "/auth";

  static final String signupUrl = "$baseUrl$prefix$auth/register";

  static final String loginUrl = "$baseUrl$prefix$auth/login";
  static final String forgotPassword = "$baseUrl$prefix$auth/forgot-password";
  static final String verifyOTP = "$baseUrl$prefix$auth/verify-otp";
  static final String resetPassword = "$baseUrl$prefix$auth/reset-password";
  static final String changePw = "$baseUrl$prefix$auth/change-password";

  static final String getAllEvents = "$baseUrl$prefix$auth/getallevent";

  static final String storeEvent = "$baseUrl$prefix$auth/store-event";
  static final String updateEvent = "$baseUrl$prefix$auth/updateevent";

  static final String becomeOrganizer = "$baseUrl$prefix$auth/become-organizer";
  static final String eventDetails =
      "$baseUrl$prefix$auth/geteventdetails/#id#";

  static final String myEvents = "$baseUrl$prefix$auth/getorganizerevent";
  static final String getCategories = "$baseUrl$prefix$auth/getallcategory";
  static final String getallevent = "$baseUrl$prefix$auth/getallevent";

  static final String getallvenue = "$baseUrl$prefix$auth/getallvenue";

  static final String bookEvent = "$baseUrl$prefix$auth/book-event";

  static final String searchEvents =
      "$baseUrl$prefix$auth/searchevent?title=#keyword#";
  static final String bookedEvents = "$baseUrl$prefix$auth/getorganizerevent";

  static final String deleteEvents = "$baseUrl$prefix$auth/deletevent";
  static final String addFavourite = "$baseUrl$prefix$auth/addtofavourites";
  static final String deleteFav = "$baseUrl$prefix$auth/deletefavouriteevent";
  static final String getFavList =
      "$baseUrl$prefix$auth/getorganizerfavouriteevent";

  static String checkWishListUrl = "$baseUrl$prefix/auth/wishlist-check";

  static final String getEventById = "$baseUrl$prefix/auth/categorywiseevent/2";

  static final String updateProfile = "$baseUrl$prefix/auth/updateprofile";
}
