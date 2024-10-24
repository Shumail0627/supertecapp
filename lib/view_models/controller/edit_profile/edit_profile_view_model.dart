import 'package:supertec_app_clean_code/models/user_info_model/user_info_model.dart';
import 'package:supertec_app_clean_code/repository/editinfo_repository/editinfo_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class EditProfileViewModel {
  final pref = UserPreferences();
  final _apiServices = EditProfileRepository();
  final fatherName = TextEditingController().obs;
  final cnicNumber = TextEditingController().obs;
  final dateOfBirth = TextEditingController().obs;
  final homeAddress = TextEditingController().obs;
  final departmentCompany = TextEditingController().obs;
  final dateOfJoining = TextEditingController().obs;

  editProfile() async {
    final user = await pref.getUser();
    UserInfoModel data = UserInfoModel(
      id: user.id,
      fatherName: fatherName.value.text,
      homeAddress: homeAddress.value.text,
      dob: dateOfBirth.value.text,
      cnic: cnicNumber.value.text,
      department: departmentCompany.value.text,
      doj: dateOfJoining.value.text,
    );

    _apiServices.editProfileInfoApi(data.toJson()).then((value) {
      if (value['message'] == 'Information Updated') {
        Utils.toastMessage(value['message']);
        cnicNumber.value.clear();
        fatherName.value.clear();
        dateOfBirth.value.clear();
        dateOfJoining.value.clear();
        homeAddress.value.clear();
        departmentCompany.value.clear();
      } else {
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) => Utils.toastMessage(
        "Error occurred. Check your network or try again later."));
  }
}
