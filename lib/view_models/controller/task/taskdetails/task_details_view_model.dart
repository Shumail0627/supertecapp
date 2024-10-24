import 'package:supertec_app_clean_code/repository/taskstatus_repository/taskstatus_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class TaskUpdateViewModel extends GetxController {
  final _apiService = TaskStatusRepository();
  final preferences = UserPreferences();
  RxString buttonText = "Mark as Complete".obs;
  final taskVM = Get.put(TaskViewModel());
  taskCompleteCheckApi(taskId) async {
    final url =
        'http://superteclabs.com/apis2/updatestatus.php?task_id=$taskId';

    _apiService.taskStatusApi(url).then((value) {
      if (!value['error']) {
        buttonText.value = 'Completed';
        Utils.toastMessage(value['message']);
        preferences.getUser().then((value) {
          taskVM.taskApi(id: value.id.toString());
        });
      } else {
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) => Utils.toastMessage(
        "Error occurred. Check your network or try again later."));
  }
}
