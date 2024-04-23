class AccessToken {
  String? accessToken;
  String? tokenType;
  String? expiresAt;

  AccessToken({this.accessToken, this.tokenType, this.expiresAt});

  AccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    return data;
  }

  @override
  String toString() {
    return "$tokenType $accessToken";
  }
}
