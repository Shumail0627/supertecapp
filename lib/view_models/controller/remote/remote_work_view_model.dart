import 'package:supertec_app_clean_code/repository/remote_repository/remote_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class RemoteWorkViewModel extends GetxController {
  final _apiService = RemoteRepository();

  allowRemoteWork(id, remote) async {
    var data = {"id": id, "remote_working": remote};
    _apiService.remoteWorkApi(data).then((value) {
      if (!value['error']) {
        Get.back();
        Utils.toastMessage(value['message']);
      } else {
        Get.back();
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) {
      Get.back();
      return Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }
}
