class RegisterUserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? companyToken;

  RegisterUserModel(
      {this.name, this.email, this.phone, this.password, this.companyToken});

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    companyToken = json['company_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['company_token'] = companyToken;
    return data;
  }
}
