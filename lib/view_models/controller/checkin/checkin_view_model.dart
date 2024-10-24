import '../../../models/checkinPref/checkin_pref_model.dart';
import '../../../utils/new_all_imports.dart';

class CheckInModel extends GetxController {
  // GetLocation getLocation = Get.put(GetLocation());
  TaskViewModel taskViewModel = Get.put(TaskViewModel());
  final checkPref = UserCheckPref();
  UserPreferences preferences = UserPreferences();
  final _api = CheckInRepository();
  RxBool loading = false.obs;
  RxBool? showCheckinButton = false.obs;
  String? url;
  String? message;
  List task = [];
  List? pendingTask;

  void checkin(context) async {
    loading.value = true;
    final user = await preferences.getUser();
    loading.value = true;
    if (Utils.formatDay != 'Sunday') {
      Position currentPosition = await getLocation();
      url =
          "http://superteclabs.com/apis2/checkin2.php?date=${Utils.formatDate}&day=${Utils.formatDay}&time=${Utils.formatTime}&userid=${user.id}&token=${user.companyToken}&latitude=${currentPosition.latitude}&longitude=${currentPosition.longitude}";
      // log(url.toString());
      _api.checkinApi(url).then((value) {
        loading.value = false;
        if (!value['Error']) {
          final data = CheckPrefModel(
              isCheckedIn: true, lastCheckOutTime: DateTime.now());
          checkPref.setCheckin(data);
          showCheckinButton!.value = true;
          loading.value = false;
          String message = value['message'];
          Utils.toastMessage(message);
          task = taskViewModel.taskList;
          pendingTask = task
              .where((task) => task.taskStatus == "pending")
              .map((task) => task.taskDescription)
              .toList();
          loading.value = false;
          showAdaptiveDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const TextComponent(
                text: 'Notify Sir Rehan Allahwala on whatsapp?',
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    // preferences.getUser().then((value) {
                    // showWhatsAppBottomSheet(context);
                    readyMessage(context);
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
        } else {
          loading.value = false;
          return Utils.toastMessage(value['message']);
        }
      }).onError((error, stackTrace) {
        loading.value = false;
        return Utils.toastMessage(
            "Error occurred. Check your network or try again later.");
      });
    } else {
      loading.value = false;
      // await getLocation;
    }
  }

  // showWhatsAppBottomSheet(context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ListTile(
  //             title: const CustomText(text: 'WhatsApp'),
  //             onTap: () {
  //               // Handle WhatsApp selection
  //               // You can add your logic here
  //               // For example, call a method to send a message on WhatsApp
  //               readyMessage(context, "WhatsApp");
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             title: const CustomText(text: 'WhatsApp Business'),
  //             onTap: () {
  //               // Handle WhatsApp Business selection
  //               // You can add your logic here
  //               // For example, call a method to send a message on WhatsApp Business
  //               readyMessage(context, "WhatsApp Business");
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  readyMessage(context) async {
    final user = await preferences.getUser();
    String id = user.id.toString();
    message =
        "Assalum-u-Allaikum ! \nChecked in at ${Utils.formatTime} \nLocation:   \nName: ${user.name} \nDate:  ${Utils.formatDate} \n\nPending Tasks: \n $pendingTask";
    // log(pendingTask.toString());
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
    String url = "https://api.whatsapp.com/send?phone=$number&text=$message";
    Utils.runUrl(url: url, context: context);
  }
}
