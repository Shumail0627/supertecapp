import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PageAppLogo(title: 'Supertec'),
            CustomButton(
                onPressed: () => Get.toNamed(RouteName.employeeLoginView),
                buttonText: 'Employee'),
            verticalPadding(
              v: 3,
              child: const Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      color: AppColor.black,
                    ),
                  ),
                  TextComponent(text: 'OR'),
                  Expanded(
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
                onPressed: () => Get.toNamed(RouteName.adminLoginView),
                buttonText: 'Admin'),
          ],
        ),
      ),
    );
  }
}
