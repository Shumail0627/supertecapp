
import 'package:supertec_app_clean_code/models/colleagues/colleagues_model.dart';
import 'package:supertec_app_clean_code/repository/colleagues_repository/colleagues_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ColleaguesViewModel extends GetxController {
  final search=TextEditingController().obs;

  RxString companyName = 'Rehan Foundation'.obs;
  final _apiServices = ColleaguesRepository();
  final _userPreferences = UserPreferences();
  final _adminPreferences = AdminPreferences();
  final rxRequestStatus = Status.LOADING.obs;
 RxBool searchbar=false.obs;
  void setStatus(Status value) => rxRequestStatus.value = value;
  RxList<ColleaguesModel> colleagesusList = <ColleaguesModel>[].obs;
  RxList<ColleaguesModel> filteredColleagues  = <ColleaguesModel>[].obs;

  getColleagusData() async {
    List<ColleaguesModel> dataList = [];
    final user = await _userPreferences.getUser();
    final admin = await _adminPreferences.getAdmin();
    Map data = {"company_token": user.companyToken ?? admin.companyToken};

    _apiServices.colleaguesApi(data).then((value) {
      if (value != []) {
        for (var i in value) {
          dataList.add(ColleaguesModel.fromJson(i));
        }
        colleagesusList.assignAll(dataList);
        companyName.value = admin.companyName.toString();
        filterColleagues(search.value.text);
        setStatus(Status.COMPLETED);
      } else {
        Utils.toastMessage('No Task Available');
        setStatus(Status.COMPLETED);
        return null;
      }
    }).onError((error, stackTrace) {
      setStatus(Status.ERROR);
    });
  }

  colleaguesRefresh() {
    setStatus(Status.LOADING);
    getColleagusData();
  }
  void filterColleagues(String v) {
    if (v.isEmpty) {
      filteredColleagues.assignAll(colleagesusList);
    } else {
      filteredColleagues.assignAll(colleagesusList
          .where((colleague) =>
          colleague.name!.toLowerCase().contains(v.toLowerCase()))
          .toList());
    }
  }
}
