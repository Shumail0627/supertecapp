import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/login/login_view_model.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({super.key});

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  final _formkey = GlobalKey<FormState>();
  AdminLoginViewModel controller = Get.put(AdminLoginViewModel());
  @override
  Widget build(BuildContext context) {
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
                      const PageAppLogo(title: 'Admin Login'),
                      TextFieldComponent(
                          textSize: 14,
                          label: 'Company Email',
                          validator: emailValidation,
                          controller: controller.emailController.value,
                          currentFocus: controller.emailFocus,
                          nextFocus: controller.passFocus,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      verticalPadding(
                        child: Obx(
                          () => TextFieldComponent(
                              label: 'Password',
                              textSize: 14,
                              obscureText: controller.showPass.value,
                              currentFocus: controller.passFocus,
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
                            controller.adminloginApi();
                          }
                        },
                        buttonText: 'LOGIN',
                        loading: controller.loading.value,
                      )),
                      TextButton(
                          onPressed: () =>
                              Get.toNamed(RouteName.resgisterCompanyView),
                          child: const TextComponent(
                              fweight: FontWeight.bold,
                              size: 12,
                              color: Color.fromARGB(255, 18, 113, 190),
                              text:
                                  'Haven\'t Registered Company? Sign Up Now')),
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
