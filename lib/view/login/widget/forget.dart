import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/forget/forget_view_model.dart';
import 'package:supertec_app_clean_code/view_models/controller/login/login_view_model.dart';

class EmployeeForgetPass extends StatelessWidget {
  EmployeeForgetPass({super.key});
  final forgetVM = Get.put(ForgetViewModel());
  final employeeLoginVM = Get.put(EmployeeLoginViewModel());

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const TextComponent(
                      text: 'Forget Password',
                      fweight: FontWeight.bold,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldComponent(
                          label: 'Email',
                          controller: employeeLoginVM.forgetEmail.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        sizedBox(),
                        Obx(
                          () => CustomButton(
                            onPressed: () {
                              forgetVM.forgetRequestApi();
                            },
                            loading: forgetVM.loading.value,
                            buttonText: 'Get Password',
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        child: const TextComponent(
            size: 12,
            fweight: FontWeight.bold,
            color: AppColor.darkBlue,
            text: 'forgot password?'));
  }
}
