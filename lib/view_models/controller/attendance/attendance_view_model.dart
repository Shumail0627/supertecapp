// import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:supertec_app_clean_code/models/attendance/attendance_model.dart';
import 'package:supertec_app_clean_code/models/salary/salary_model.dart';
import 'package:supertec_app_clean_code/repository/attendance_repository/attendance_repository.dart';
import 'package:supertec_app_clean_code/repository/salary_repository/salary_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class AttendanceViewModel extends GetxController {
  final _apiAttendance = AttendanceRepository();
  final _apiSalary = SalaryRepository();
  UserPreferences pref = UserPreferences();
  void setAttendanceRxRequestStatus(Status value) =>
      rxAttendanceRequestStatus.value = value;
  void setSalaryRxRequestStatus(Status value) =>
      rxSalaryRequestStatus.value = value;
  final rxAttendanceRequestStatus = Status.LOADING.obs;
  final rxSalaryRequestStatus = Status.LOADING.obs;
  String formatMonth = DateFormat.MMMM().format(DateTime.now());
  String formatYear = DateFormat.y().format(DateTime.now());
  String formatMonthInt = DateFormat.M().format(DateTime.now());
  RxString error = ''.obs;
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  final salaryData = SalaryModel().obs;
  void salarySave(SalaryModel value) => salaryData.value = value;
  void setError(String value) => error.value = value;

  attendanceRecord({required String id}) {
    List<AttendanceModel> attendancerecord = [];
    final url =
        'http://superteclabs.com/apis2/AttendanceRecord2.php?id=$id&month=$formatMonth&year=$formatYear';
    return _apiAttendance.attendanceApi(url).then((value) {
      if (value != []) {
        for (var i in value) {
          attendancerecord.add(AttendanceModel.fromJson(i));
        }
        attendanceList.assignAll(attendancerecord);
        setAttendanceRxRequestStatus(Status.COMPLETED);
      } else {
        Utils.toastMessage('No Data Available');
        setAttendanceRxRequestStatus(Status.COMPLETED);
        return null;
      }
    }).onError((error, stackTrace) {
      setAttendanceRxRequestStatus(Status.ERROR);
      // log("error attendance: ${error.toString()}");
      setError("Error occurred. Check your network or try again later.");
    });
  }

  salary({required String id}) {
    final url =
        "https://superteclabs.com/admin/salaryapi.php?id=$id&month=$formatMonthInt&year=$formatYear";
    _apiSalary.salaryApi(url).then((value) {
      final data = SalaryModel.fromJson(value);
      salarySave(data);
      setSalaryRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackTrace) {
      setSalaryRxRequestStatus(Status.ERROR);
      // log("error salary: ${error.toString()}");
      setError("Error occurred. Check your network or try again later.");
    });
  }

  // attendanceRefresh() {
  //   setRxRequestStatus(Status.LOADING);
  //   attendanceRecord();
  //   salary();
  // }
}
