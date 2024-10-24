class ColleaguesModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? image;
  String? status;
  String? loginStatus;
  String? day;
  String? checkinTime;
  String? checkoutTime;
  String? shiftStart;
  String? shiftEnd;
  String? userLocationLat;
  String? userLocationLon;
  String? office;
  String? strtAddress;
  String? notifToken;
  String? salary;

  ColleaguesModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.image,
      this.status,
      this.loginStatus,
      this.day,
      this.checkinTime,
      this.checkoutTime,
      this.shiftStart,
      this.shiftEnd,
      this.userLocationLat,
      this.userLocationLon,
      this.office,
      this.strtAddress,
      this.notifToken,
      this.salary});

  ColleaguesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    image = json['image'];
    status = json['status'];
    loginStatus = json['login_status'];
    day = json['day'];
    checkinTime = json['checkin_time'];
    checkoutTime = json['checkout_time'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    userLocationLat = json['user_location_lat'];
    userLocationLon = json['user_location_lon'];
    office = json['office'];
    strtAddress = json['strt_address'];
    notifToken = json['notif_token'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['image'] = image;
    data['status'] = status;
    data['login_status'] = loginStatus;
    data['day'] = day;
    data['checkin_time'] = checkinTime;
    data['checkout_time'] = checkoutTime;
    data['shift_start'] = shiftStart;
    data['shift_end'] = shiftEnd;
    data['user_location_lat'] = userLocationLat;
    data['user_location_lon'] = userLocationLon;
    data['office'] = office;
    data['strt_address'] = strtAddress;
    data['notif_token'] = notifToken;
    data['salary'] = salary;
    return data;
  }
}
