import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class SplashServices {
  final userPreference = UserPreferences();
  final adminPreference = AdminPreferences();
  final agreementPreference = UsersAgreement();

  Future<void> isLogin() async {
    final user = await userPreference.getUser();
    final agreement = await agreementPreference.getData();
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'rehanfoundation@supertec.com', password: '12341234');
    FirebaseMessaging.instance.subscribeToTopic('all_users');
    if (agreement.accept == true) {
      if (user.login == true) {
        await navigateTo(RouteName.customBottomNavigationView);
      } else {
        final admin = await adminPreference.getAdmin();

        if (admin.adminLogin == true) {
          await navigateTo(RouteName.adminHomeView);
        } else {
          await navigateTo(RouteName.start);
        }
      }
    } else {
      await navigateTo(RouteName.privacyPolicyView);
    }
  }

  Future<void> navigateTo(String routeName) async {
    Timer(const Duration(seconds: 3), () {
      Get.until((route) => false);
      Get.toNamed(routeName);
    });
  }
}
