class CheckPrefModel {
  bool? isCheckedIn;
  DateTime? lastCheckOutTime = DateTime.now();

  CheckPrefModel({this.isCheckedIn, this.lastCheckOutTime});

  CheckPrefModel.fromJson(Map<String, dynamic> json) {
    isCheckedIn = json['isCheckedIn'];
    lastCheckOutTime = json['lastCheckOutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCheckedIn'] = isCheckedIn;
    data['lastCheckOutTime'] = lastCheckOutTime;
    return data;
  }
}
