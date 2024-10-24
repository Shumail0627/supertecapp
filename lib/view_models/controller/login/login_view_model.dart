import '../../../models/login/admin_model.dart';
import '../../../utils/new_all_imports.dart';

class EmployeeLoginViewModel extends GetxController {
  final _api = Loginrepository();
  final preferences = UserPreferences();

  RxBool showPass = true.obs;
  RxBool loading = false.obs;
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  final forgetEmail = TextEditingController().obs;
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  void loginApi() {
    loading.value = true;
    Map data = {
      "email": emailController.value.text.trim(),
      "password": passController.value.text
    };
    _api.employeeLoginApi(data).then((value) {
      if (value['message'] != 'Wrong Credentials!') {
        UserModel userModel = UserModel.fromJson(value);
        loading.value = false;
        preferences.saveUser(userModel).then((value) {
          Get.until((route) => false);
          return Get.toNamed(RouteName.customBottomNavigationView);
        });
        // Utils.toastMessage('Login Sucess $value');
      } else {
        final message = value['message'] == 'Wrong Credentials!'
            ? "Wrong Email or Pass"
            : value['message'];
        loading.value = false;
        return Utils.toastMessage(message);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      return Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }

  void obsecureEye() {
    showPass.value = !showPass.value;
  }
}

class AdminLoginViewModel extends GetxController {
  RxBool showPass = true.obs;
  final _apiServices = AdminLoginrepository();
  final adminPreferences = AdminPreferences();
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  RxBool loading = false.obs;

  void adminloginApi() async {
    loading.value = true;
    var data = {
      "email": emailController.value.text.trim(),
      "password": passController.value.text
    };
    _apiServices.adminLoginApi(data).then((value) {
      if (value['message'] != 'Wrong Credentials!') {
        AdminLoginModel adminModel = AdminLoginModel.fromJson(value);
        loading.value = false;
        Utils.toastMessage(value['message']);
        adminPreferences.saveAdmin(adminModel).then((value) {
          Get.until((route) => false);

          return Get.toNamed(RouteName.adminHomeView);
        });
        // Utils.toastMessage('Login Sucess $value');
      } else {
        final message = value['message'] == 'Wrong Credentials!'
            ? "Wrong Email or Pass"
            : value['message'];
        loading.value = false;
        return Utils.toastMessage(message);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }

  void obsecureEye() {
    showPass.value = !showPass.value;
  }
}
