import 'package:supertec_app_clean_code/repository/taskassign_repository/taskassign_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class AssignTaskViewModel extends GetxController {
  final title = TextEditingController().obs;
  final desc = TextEditingController().obs;
  final _apiServices = TaskAssignRepository();
  // final navVM=Get.put(dependency)
  RxBool loading = false.obs;

  taskAssign({required String id}) async {
    loading.value = true;
    var data = {
      'id': id,
      'title': title.value.text,
      'desc': desc.value.text,
    };
    _apiServices.taskAssignApi(data).then((value) {
      if (!value['error']) {
        loading.value = false;
        title.value.clear();
        desc.value.clear();
        // Get.back();
        Utils.toastMessage(value['message']);
      } else {
        loading.value = false;
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      return Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }
}
