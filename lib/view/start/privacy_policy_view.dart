import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Container(
          width: double.infinity,
          color: AppColor.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalPadding(
                        child: const TextComponent(
                      text: 'Privacy Policy',
                      size: 19,
                      fweight: FontWeight.w600,
                    )),
                    const TextComponent(
                      text:
                          "Supertec Office collects employee's location data in the background even when the app is not in use.The collected data will be used by admins of your organization for the following purposes:\n\n•Security checks on employees during working hours.\n•Monthly keep the record of location from where employee checks in.\n•To track the location of employees during working hours.",
                      maxline: 20,
                      color: Color(0xff8E8E8E),
                    ),
                    verticalPadding(
                        child: const TextComponent(
                      text: 'DISCLAIMER:',
                      size: 19,
                      color: Color(0xff2196F3),
                      fweight: FontWeight.w600,
                    )),
                    const TextComponent(
                      text:
                          "We do not sell or disclose your location data to any third party or business partners.This data remains completely private and is used by admins of your organizations for above mentioned purposes only.",
                      maxline: 20,
                      color: Color(0xff8E8E8E),
                    ),
                    verticalPadding(
                        child: CustomButton(
                            onPressed: () {
                              UsersAgreement().save(true).whenComplete(() {
                                Utils.toastMessage('Accepted');
                                Get.until((route) => false);
                                Get.toNamed(RouteName.start);
                              });
                            },
                            buttonText: 'I accept'.toUpperCase()))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
