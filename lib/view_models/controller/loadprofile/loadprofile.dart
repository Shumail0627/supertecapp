import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class LoadProfileModel {
  UserPreferences pref = UserPreferences();
  final _api = LoadProfileRepository();
  Map? data;
  final navVM = Get.put(NavigatorBarModel());
  RxString image = ''.obs;
  RxString name = ''.obs;

  updateImg() {
    pref.getUser().then((value) {
      data = {"id": value.id};
    });
    _api.loadIMGApi(data).then((value) {
      if (value['message'] != 'Image could not be loaded!') {
        navVM.image.value = value['image'];
        navVM.name.value = value['name'];
        pref
            .saveImg(value['image'], value['remote_working'],
                value['shift_start'], value['shift_end'])
            .then((value) => Utils.toastMessage('Please Wait'));
      } else {
        // final message = value['message'];
        // Utils.toastMessage(message);
        updateImg();
      }
    });
  }
}
