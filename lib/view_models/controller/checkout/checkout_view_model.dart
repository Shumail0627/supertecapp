// import 'dart:developer';

import 'package:supertec_app_clean_code/models/checkinPref/checkin_pref_model.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class CheckoutViewModel {
  final _pref = UserPreferences();
  final checkPref = UserCheckPref();
  final checkInVM = Get.put(CheckInModel());
  final _api = CheckoutRepository();
  TaskViewModel taskViewModel = Get.put(TaskViewModel());
  RxBool loading = false.obs;

  void checkout(BuildContext context) async {
    loading.value = true;

    final user = await _pref.getUser();
    _pref.getUser().then((value) {
      final url =
          'http://superteclabs.com/apis2/checkout.php?date=${Utils.formatDate}&day=${Utils.formatDay}&time=${Utils.formatTime}&userid=${user.id}';
      _api.checkoutApi(url).then((value) {
        // log(url);
        if (value.containsKey('error')) {
          String message =
              value['error'] == 'No Comment found Please Add a comment!'
                  ? 'No Worklog found Please Add a worklog'
                  : value['error'];
          value['error'] == "You have already checked-out!"
              ? checkPref.setCheckin(CheckPrefModel(isCheckedIn: false))
              : Utils.toastMessage(message);
          Utils.toastMessage(message);
          loading.value = false;
        } else {
          checkPref.setCheckin(CheckPrefModel(
              isCheckedIn: false, lastCheckOutTime: DateTime.now()));
          checkInVM.showCheckinButton!.value = false;
          loading.value = false;
          final data = CheckoutModel.fromJson(value);
          if (value.containsKey('message')) {
            Utils.toastMessage("${data.message} ${data.name}");
          }
          // List<UserTaskModel> tasks = await Api.taskApi(LocalStorage.id);
          List pendingTask = taskViewModel.taskList
              .where((task) => task.taskStatus == "pending")
              .map((task) => task.taskDescription)
              .toList();
          List completeTask = taskViewModel.taskList
              .where((task) => task.taskStatus == "complete")
              .map((task) => task.taskDescription)
              .toList();
          final taskComment = data.taskMessages![0].taskComment;
          // task = taskViewModel.taskList;
          showAdaptiveDialog(
            context: Get.context ?? context,
            builder: (context) => AlertDialog(
              title: const TextComponent(
                text: 'Notify Check out to Sir Rehan Allahwala on whatsapp?',
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    String id = user.id.toString();
                    String message =
                        "Assalum u Alaikum ! \nChecked out at  ${Utils.formatTime} \nName: ${user.name} \nDate: ${Utils.formatDate} \nDaily Work Log\n\nCompleted Tasks: \n $completeTask \n \nPending Tasks: \n $pendingTask \n\nWorklog: \n $taskComment";
                    String number = id == "4" ||
                            id == "9" ||
                            id == "45" ||
                            id == "51" ||
                            id == "62" ||
                            id == "94" ||
                            id == "122" ||
                            id == "10" ||
                            id == "29" ||
                            id == "130" ||
                            id == "28" ||
                            id == "79" ||
                            id == "179"
                        ? "+12126559343"
                        : "+923058887388";
                    String url =
                        "https://api.whatsapp.com/send?phone=$number&text=$message";
                    Utils.runUrl(url: url, context: context)
                        .whenComplete(() => Get.back());
                  },
                  child: const TextComponent(text: 'Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const TextComponent(text: 'No'),
                )
              ],
            ),
          );
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        return Utils.toastMessage(
            "Error occurred. Check your network or try again later.");
      });
    });
  }
}
