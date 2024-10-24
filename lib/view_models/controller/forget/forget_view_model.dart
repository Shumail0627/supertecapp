import 'package:supertec_app_clean_code/repository/forget_repository/forget_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/login/login_view_model.dart';

class ForgetViewModel extends GetxController {
  final _apiService = ForgetRepository();
  final employeeLoginVM = Get.put(EmployeeLoginViewModel());
  RxBool loading = false.obs;

  forgetRequestApi() {
    loading.value = true;
    final url =
        "http://superteclabs.com/apis2/forgotPass.php?email=${employeeLoginVM.forgetEmail.value.text.trim()}";
    _apiService.forgetApi(url).then((value) {
      loading.value = false;
      if (value['success']) {
        Utils.toastMessage("${value['message']} or check Spam");
        employeeLoginVM.forgetEmail.value.clear();
        Get.back();
      } else {
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.toastMessage("Error Check your network or try again later.");
    });
  }
}
