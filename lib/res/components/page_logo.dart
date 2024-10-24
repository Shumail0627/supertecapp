import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class PageAppLogo extends StatelessWidget {
  const PageAppLogo({super.key, this.persent = 0.15, required this.title});
  final double persent;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageAssets.appLogo,
          height: Get.height * persent,
        ),
        verticalPadding(
            child: TextComponent(
          text: title!,
          fweight: FontWeight.bold,
          size: 20,
          color: AppColor.darkBlue,
        )),
      ],
    );
  }
}
