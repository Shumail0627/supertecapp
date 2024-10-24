import '../../utils/new_all_imports.dart';
import '../../view_models/controller/forget/forget_view_model.dart';
import '../../view_models/controller/login/login_view_model.dart';
import 'widget/forget.dart';

class EmployeeLoginView extends StatefulWidget {
  const EmployeeLoginView({super.key});

  @override
  State<EmployeeLoginView> createState() => _EmployeeLoginViewState();
}

class _EmployeeLoginViewState extends State<EmployeeLoginView> {
  final controller = Get.put(EmployeeLoginViewModel());
  final forgetVM = Get.put(ForgetViewModel());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // log('rebuild');
    return Scaffold(
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PageAppLogo(title: 'Employee Login'),
                      TextFieldComponent(
                          textSize: 14,
                          label: 'Email',
                          currentFocus: controller.emailFocus,
                          nextFocus: controller.passFocus,
                          validator: emailValidation,
                          controller: controller.emailController.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      verticalPadding(
                        child: Obx(
                          () => TextFieldComponent(
                              label: 'Password',
                              textSize: 14,
                              currentFocus: controller.passFocus,
                              obscureText: controller.showPass.value,
                              validator: fieldValidator,
                              suffixIcon: IconButton(
                                  onPressed: controller.obsecureEye,
                                  icon: controller.showPass.value
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.remove_red_eye_outlined)),
                              controller: controller.passController.value,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      verticalPadding(
                          child: CustomButton(
                        onPressed: () {
                          if (_formkey.currentState?.validate() ?? false) {
                            controller.loginApi();
                          }
                        },
                        buttonText: 'LOGIN',
                        loading: controller.loading.value,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  Get.toNamed(RouteName.employeeSignUpView),
                              child: const TextComponent(
                                  fweight: FontWeight.bold,
                                  size: 12,
                                  color: AppColor.darkBlue,
                                  text: 'No Account? Sign Up')),
                          EmployeeForgetPass()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
