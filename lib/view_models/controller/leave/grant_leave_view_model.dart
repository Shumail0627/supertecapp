import 'package:intl/intl.dart';
import 'package:supertec_app_clean_code/repository/leave_repository/leave_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class GrantLeaveViewModel extends GetxController {
  RxInt selectLeave = 0.obs;
  final _apiServices = LeaveRepository();

  grantLeaves({required String id}) async {
    String year = DateFormat('yyyy').format(DateTime.now());
    String month = DateFormat('MMMM').format(DateTime.now());
    final url =
        "http://superteclabs.com/apis2/Grantleaves.php?id=$id&month=$month&year=$year&leaves=${selectLeave.value}";

    _apiServices.leaveApi(url).then((value) {
      if (value['message'] == "Leaves Assigned") {
        Utils.toastMessage(value['message']);
      } else {
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) => Utils.toastMessage(
        "Error occurred. Check your network or try again later."));
  }
}
