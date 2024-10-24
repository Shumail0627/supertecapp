class FirebaseLocationModel {
  String? userId;
  String? latitude;
  String? longtitude;
  String? time;
  String? notifToken;

  FirebaseLocationModel(
      {this.userId,
      this.latitude,
      this.longtitude,
      this.time,
      this.notifToken});

  FirebaseLocationModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    time = json['time'];
    notifToken = json['notifToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['latitude'] = latitude;
    data['longtitude'] = longtitude;
    data['time'] = time;
    data['notifToken'] = notifToken;
    return data;
  }
}
