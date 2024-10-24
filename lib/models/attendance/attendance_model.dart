class AttendanceModel {
  String? userId;
  String? checkinDate;
  String? checkinDay;
  String? checkinTime;
  String? shiftStart;
  String? shiftEnd;
  String? office;
  String? checkoutTime;

  AttendanceModel(
      {this.userId,
      this.checkinDate,
      this.checkinDay,
      this.checkinTime,
      this.shiftStart,
      this.shiftEnd,
      this.office,
      this.checkoutTime});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    checkinDate = json['checkin_date'];
    checkinDay = json['checkin_day'];
    checkinTime = json['checkin_time'];
    shiftStart = json['shift_start'];
    shiftEnd = json['shift_end'];
    office = json['office'];
    checkoutTime = json['checkout_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['checkin_date'] = checkinDate;
    data['checkin_day'] = checkinDay;
    data['checkin_time'] = checkinTime;
    data['shift_start'] = shiftStart;
    data['shift_end'] = shiftEnd;
    data['office'] = office;
    data['checkout_time'] = checkoutTime;
    return data;
  }
}
