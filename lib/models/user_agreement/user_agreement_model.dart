class UserAgreementModel {
  bool? accept = false;

  UserAgreementModel({this.accept});

  UserAgreementModel.fromJson(Map<String, dynamic> json) {
    accept = json['accept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accept'] = accept;
    return data;
  }
}
