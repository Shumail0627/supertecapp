import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class InternetExpection extends StatelessWidget {
  const InternetExpection({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_off,
          size: Get.height * 0.10,
          color: Colors.red,
        ),
        verticalPadding(
          child: TextComponent(
            textAlign: TextAlign.center,
            text:
                "We're unable to show results.\nPlease check your data\nconenction.",
            style: Utils.boldStyle(size: 17),
          ),
        ),
        CustomButton(
            onPressed: onPressed,
            radius: 20,
            width: 150,
            color: Colors.red,
            buttonText: "Retry")
      ],
    ));
  }
}
