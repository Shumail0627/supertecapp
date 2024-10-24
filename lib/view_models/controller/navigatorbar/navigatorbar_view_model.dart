import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class NavigatorBarModel {
  RxInt currentIndex = 0.obs;
  RxString id = ''.obs;
  RxString name = ''.obs;
  RxString companyName = ''.obs;
  RxString image = ''.obs;
  final pref = UserPreferences();
  setIndex(v) {
    currentIndex.value = v;
  }

  // setDetails() async {

  //   final user = await pref.getUser();

  //   id.value = user.id!;
  //   name.value = user.name!;
  //   companyName.value = user.companyName!;
  //   image.value = user.image!;
  // }
}
