import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? elevation;
  final Color? color;
  final double? radius;
  final bool loading;
  final bool click;
  final String buttonText;
  final double? height, width;
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.radius,
      this.elevation,
      this.color,
      this.height,
      this.width,
      this.loading = false,
      required this.buttonText,
      this.click = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click ? onPressed : () {},
      child: Container(
          height: height ?? 40,
          width: width ?? Get.width * 0.90,
          decoration: BoxDecoration(
              color: click ? color ?? AppColor.darkBlue : AppColor.grey,
              borderRadius: BorderRadius.circular(radius ?? 10)),
          child: loading
              ? const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      )))
              : Center(
                  child: Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                )),
    );
  }
}
