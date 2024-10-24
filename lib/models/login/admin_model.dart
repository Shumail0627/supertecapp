class AdminLoginModel {
  bool? adminLogin;
  String? message;
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyToken;

  AdminLoginModel(
      {this.message,
      this.adminLogin,
      this.id,
      this.companyName,
      this.companyEmail,
      this.companyToken});

  AdminLoginModel.fromJson(Map<String, dynamic> json) {
    adminLogin = json['adminLogin'];
    message = json['message'];
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyToken = json['company_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adminLogin'] = adminLogin;
    data['message'] = message;
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['company_token'] = companyToken;
    return data;
  }
}
