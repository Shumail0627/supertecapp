import 'package:supertec_app_clean_code/res/app_urls/app_urls.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class TaskViewModel extends GetxController {
  final _api = Taskrepository();
  final rxRequestStatus = Status.LOADING.obs;
  // RxList taskList = [].obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList<UserTaskModel> taskList = <UserTaskModel>[].obs;
  // void setTaskList(var value) => taskList.value = value;

  taskApi({required String id}) {
    final url = "${AppUrl.employeeTaskGetUrl}?userid=$id";
    List<UserTaskModel> datalist = [];
    _api.employeeTaskApi(url).then((value) {
      if (value != []) {
        for (var i in value) {
          datalist.add(UserTaskModel.fromJson(i));
        }
        taskList.assignAll(datalist);
        setRxRequestStatus(Status.COMPLETED);
      } else {
        Utils.toastMessage('No Task Available');
        setRxRequestStatus(Status.COMPLETED);
        return null;
      }
    }).onError((error, stackTrace) {
      setRxRequestStatus(Status.ERROR);
      Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }

  // refreshTask() {
  //   setRxRequestStatus(Status.LOADING);
  //   taskApi();
  // }
}
