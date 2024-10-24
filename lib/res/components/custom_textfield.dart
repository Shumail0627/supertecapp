import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class TextFieldComponent extends StatelessWidget {
  final String? hintText;
  final String label;
  final double? textSize;
  final TextEditingController controller;
  final InputBorder? border;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final String? Function(String?)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? nextFocus;
  final int? line;
  final String? Function(String?)? validator;

  final FocusNode? currentFocus;

  const TextFieldComponent({
    super.key,
    this.hintText,
    required this.label,
    this.textSize,
    required this.controller,
    this.border,
    this.autofocus,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.currentFocus,
    this.onFieldSubmitted,
    this.line,
    this.floatingLabelAlignment,
    this.onChanged,
    this.onEditingComplete,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      focusNode: currentFocus,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete ??
          (currentFocus != null
              ? () {
                  currentFocus?.unfocus();
                  if (nextFocus != null) {
                    nextFocus?.requestFocus();
                  }
                }
              : null),
      decoration: InputDecoration(
          label: TextComponent(
            text: label,
            size: textSize ?? 15,
            fweight: FontWeight.w600,
          ),
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          alignLabelWithHint: true,
          floatingLabelAlignment: floatingLabelAlignment,
          filled: true,
          hintText: hintText ?? label,
          border: border ?? InputBorder.none),
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(fontSize: textSize ?? 15, color: Colors.black),
      keyboardType: keyboardType,
      autofocus: autofocus ?? false,
      maxLines: line ?? 1,
      minLines: 1,
      validator: validator,
    );
  }
}
