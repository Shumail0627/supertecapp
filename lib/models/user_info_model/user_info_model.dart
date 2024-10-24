class UserInfoModel {
  String? id;
  String? fatherName;
  String? cnic;
  String? dob;
  String? doj;
  String? homeAddress;
  String? department;

  UserInfoModel(
      {this.id,
      this.fatherName,
      this.cnic,
      this.dob,
      this.doj,
      this.homeAddress,
      this.department});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fatherName = json['fatherName'];
    cnic = json['cnic'];
    dob = json['dob'];
    doj = json['doj'];
    homeAddress = json['homeAddress'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fatherName'] = fatherName;
    data['cnic'] = cnic;
    data['dob'] = dob;
    data['doj'] = doj;
    data['homeAddress'] = homeAddress;
    data['department'] = department;
    return data;
  }
}
