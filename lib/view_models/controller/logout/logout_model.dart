import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class LogoutViewModel {
  // final _apiService = LogoutRepository();
  final pref = UserPreferences();
  final chekPref = UserCheckPref();

  // void logout() async {
  //   final user = await pref.getUser();
  //   final url = 'http://superteclabs.com/apis2/LogoutStatus.php?id=${user.id}';
  //   _apiService.logoutApi(url).then((value) {
  //     if (!value['error']) {
  //       Utils.toastMessage(value['message']);
  //       pref.removeUser();
  //       chekPref.removeCheck();
  //       // Get.until((route) => false);
  //       // Get.toNamed(RouteName.start);
  //     } else {
  //       Utils.toastMessage(value['message']);
  //     }
  //   }).onError((error, stackTrace) => Utils.toastMessage(
  //       "Error occurred. Check your network or try again later."));
  // }

  logoutDialog(BuildContext context) {
    return showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const TextComponent(
                text: 'Are you sure you want to log out',
                fweight: FontWeight.bold,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // logout();//disable logout api
                    pref.removeUser();
                    chekPref.removeCheck();
                    Get.until((route) => false);
                    Get.toNamed(RouteName.start);
                  },
                  child: const TextComponent(
                    text: 'Yes',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const TextComponent(text: 'No'),
                ),
              ],
            ));
  }
}
