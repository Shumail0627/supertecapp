class UserModel {
  bool? login;
  String? message;
  String? remoteWorking;
  String? id;
  String? name;
  String? email;
  String? companyToken;
  String? phone;
  String? image;
  String? companyId;
  String? companyName;
  String? latitudeStart;
  String? latitudeEnd;
  String? longitudeStart;
  String? longitudeEnd;
  String? shiftStart;
  String? shiftEnd;

  UserModel(
      {this.message,
      this.id,
      this.shiftStart,
      this.shiftEnd,
      this.login = false,
      this.remoteWorking = 'no',
      this.name,
      this.email,
      this.companyToken,
      this.phone,
      this.image,
      this.companyId,
      this.companyName,
      this.latitudeStart,
      this.latitudeEnd,
      this.longitudeStart,
      this.longitudeEnd});

  UserModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    remoteWorking = json['remote_working'];
    message = json['message'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    companyToken = json['company_token'];
    phone = json['phone'];
    image = json['image'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    latitudeStart = json['latitude_start'];
    latitudeEnd = json['latitude_end'];
    longitudeStart = json['longitude_start'];
    longitudeEnd = json['longitude_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['remote_working'] = remoteWorking;
    data['message'] = message;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['company_token'] = companyToken;
    data['phone'] = phone;
    data['image'] = image;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['latitude_start'] = latitudeStart;
    data['latitude_end'] = latitudeEnd;
    data['longitude_start'] = longitudeStart;
    data['longitude_end'] = longitudeEnd;
    return data;
  }
}
