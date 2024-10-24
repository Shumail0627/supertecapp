import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

import '../location/location_handle_model.dart';

class EmployeeSignUpViewModel extends GetxController {
  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final companyToken = TextEditingController().obs;
  final phoneNo = TextEditingController().obs;
  final pass = TextEditingController().obs;
  final passConfirm = TextEditingController().obs;
  final _apiService = UserRegisterRepository();
  final _signupApi = SignUpLocationRepository();
  final locationPermissionVM = Get.put(GetLocation());

  RxBool loading = false.obs;
  RxBool showPass = true.obs;
  RxBool token = false.obs;

  setTokenError(bool v) {
    token.value = v;
  }

  registerEmployee(context) async {
    RegisterUserModel data = RegisterUserModel(
      name: name.value.text,
      email: email.value.text,
      companyToken: companyToken.value.text,
      phone: phoneNo.value.text,
      password: pass.value.text,
    );
    loading.value = true;
    await locationPermissionVM.checkLocationPermission();
    Position currentLocation = await Geolocator.getCurrentPosition();
    double latitude = currentLocation.latitude;
    double longitude = currentLocation.longitude;

    if (latitude != 0 && longitude != 0) {
      _apiService.userRegisterApi(data.toJson()).then((value) async {
        if (!value['av_error']) {
          if (!value['error']) {
            loading.value = false;
            name.value.clear();
            email.value.clear();
            companyToken.value.clear();
            phoneNo.value.clear();
            pass.value.clear();
            passConfirm.value.clear();
            List<Placemark> placemarks = await placemarkFromCoordinates(
                currentLocation.latitude, currentLocation.longitude);
            Placemark place = placemarks[0];
            String streetAddress =
                '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

            String url =
                "http://superteclabs.com/apis2/InsertLocation.php?id=${value['user_id']}&user_location_lat=${latitude.toString()}&user_location_lon=${longitude.toString()}&address=$streetAddress";
            _signupApi
                .signUpLocationApi(url)
                .then((test) => null)
                .onError((error, stackTrace) => Utils.toastMessage(
                    "Error occurred. Check your network or try again later."))
                .whenComplete(() => Get.toNamed(RouteName.employeeLoginView));
            // Get.toNamed(RouteName.employeeLoginView);
            Utils.toastMessage(value['message'].toString());
          } else {
            loading.value = false;
            Utils.toastMessage(value['message'].toString());
          }
        } else {
          loading.value = false;
          final message = value['message'] == "Invalid Token"
              ? "Wrong Token"
              : value['message'];
          Utils.toastMessage(message);
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        Utils.toastMessage(
            "Error occurred. Check your network or try again later.");
      });
    } else {
      loading.value = false;
      Utils.toastMessage('Location Permission Required');
      await locationPermissionVM.checkLocationPermission();
    }
  }

  // getSignUplocation(context, id) async {
  //   loading.value = true;
  //   // String? streetAddress;

  // }
}
