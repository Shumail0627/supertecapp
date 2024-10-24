import 'package:supertec_app_clean_code/repository/company_repository/company_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class AddCompanyLocationViewModel extends GetxController {
  final _apiService = CompanyRepository();
  final pref = AdminPreferences();

  RxBool loading = false.obs;
  final latitudeStart = TextEditingController().obs;
  final latitudeEnd = TextEditingController().obs;
  final longitudeStart = TextEditingController().obs;
  final longitudeEnd = TextEditingController().obs;

  setCompanyLocation() async {
    loading.value = true;
    final admin = await pref.getAdmin();
    final data = {
      "id": admin.id,
      "Latitude_Start_Point": latitudeStart.value.text,
      "Latitude_End_Point": latitudeEnd.value.text,
      "Longitude_Start_Point": longitudeStart.value.text,
      "Longitude_End_Point": longitudeEnd.value.text,
    };
    _apiService.companyRepositoryApi(data).then((value) {
      if (!value['error']) {
        loading.value = false;
        Utils.toastMessage("Company Location Added");
        latitudeStart.value.clear();
        latitudeEnd.value.clear();
        longitudeStart.value.clear();
        longitudeEnd.value.clear();
      } else {
        loading.value = false;
        Utils.toastMessage("Something went wrong");
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }
}
