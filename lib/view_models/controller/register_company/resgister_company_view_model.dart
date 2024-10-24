import 'dart:math';

import 'package:supertec_app_clean_code/repository/register_company_repository/register_company_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class RegisterCompanyViewModel extends GetxController {
  final _apiService = RegisterCompanyRpository();

  final companyName = TextEditingController().obs;
  final companyEmail = TextEditingController().obs;
  final companyPass = TextEditingController().obs;
  final companyToken = TextEditingController().obs;

// String randomToken='';
  RxBool loading = false.obs;
  RxBool showPass = true.obs;

  register() {
    loading.value = true;
    final data = {
      "company_name": companyName.value.text,
      "company_email": companyEmail.value.text,
      "password": companyPass.value.text,
      "company_token": companyToken.value.text
    };

    _apiService.registerCompanyApi(data).then((value) {
      if (!value['error']) {
        loading.value = false;
        companyName.value.clear();
        companyEmail.value.clear();
        companyPass.value.clear();
        companyToken.value.clear();
        Utils.toastMessage(value['message']);
      } else {
        loading.value = false;
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }

  generateCompanyToken(int len) {
    const String chars =
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@\$%^&";
    Random rnd = Random();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < len; i++) {
      sb.write(chars[rnd.nextInt(chars.length)]);
    }
    companyToken.value.text = sb.toString();
  }
}
