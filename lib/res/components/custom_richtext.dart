import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class CustomRicText extends StatelessWidget {
  const CustomRicText(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.size,
      this.color1,
      this.color2});
  final String firstText;
  final String secondText;
  final double? size;
  final Color? color1, color2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: firstText,
            style: TextStyle(
                fontSize: size ?? 13,
                fontWeight: FontWeight.w500,
                color: color1 ?? Colors.black)),
        TextSpan(
            text: secondText,
            style: TextStyle(
                fontSize: size ?? 13,
                fontWeight: FontWeight.w500,
                color: color2 ?? AppColor.darkBlue))
      ])),
    );
  }
}
