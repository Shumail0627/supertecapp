import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class WorkLogController extends GetxController {
  final _api = WorkLogRepository();
  final writeLog = TextEditingController().obs;
  final _pref = UserPreferences();
  final navVM = Get.put(NavigatorBarModel());

  workLog() async {
    final value = await _pref.getUser();
    Map data = {"task_comment": writeLog.value.text, "user_id": value.id};
    if (writeLog.value.text != '') {
      _api.workLogApi(data).then((value) {
        String message = value['message'];
        if (value['error'] == false) {
          writeLog.value.clear();
          navVM.currentIndex.value = 0;
          Utils.toastMessage(message);
        } else {
          Utils.toastMessage(message);
        }
      }).onError((error, stackTrace) => Utils.toastMessage(
          "Error occurred. Check your network or try again later."));
    } else {
      return Utils.toastMessage('No Worklog found');
    }
  }
}
