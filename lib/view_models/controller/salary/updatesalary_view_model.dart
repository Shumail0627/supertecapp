import 'package:supertec_app_clean_code/repository/salary_repository/salary_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class UpdateSalaryViewModel {
  final salaryController = TextEditingController().obs;
  RxString salary = '0'.obs;
  final _apiService = SalaryRepository();

  updateSalary({required String id}) {
    final url =
        "http://superteclabs.com/apis2/updateSalary.php?id=$id&salary=${salaryController.value.text.trim()}";
    _apiService.salaryApi(url).then((value) {
      if (!value['error']) {
        Utils.toastMessage(value['message']);
      } else {
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) => Utils.toastMessage(
        "Error occurred. Check your network or try again later."));
  }

//update salary employee
  // static Future updateSalary(value, id) async {
  //   try {
  //     final url =
  //         "http://superteclabs.com/apis2/updateSalary.php?id=$id&salary=$value";
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Map<String, dynamic> responseBody = jsonDecode(response.body);
  //       if (responseBody.containsKey('message')) {
  //         String message = responseBody['message'];
  //         Utils.showMessage(message);
  //       }
  //     }
  //   } catch (e) {
  //     Utils.showMessage('Error ${e.toString()}');
  //   }
  // }
}
