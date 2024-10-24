import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class EmployeeSignUpView extends StatefulWidget {
  const EmployeeSignUpView({super.key});

  @override
  State<EmployeeSignUpView> createState() => _EmployeeSignUpViewState();
}

class _EmployeeSignUpViewState extends State<EmployeeSignUpView> {
  final _formKey = GlobalKey<FormState>();
  EmployeeSignUpViewModel employeeSignUpVM = Get.put(EmployeeSignUpViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageAssets.appLogo,
                    height: Get.height * 0.10,
                  ),
                  verticalPadding(
                      child: const TextComponent(
                    text: 'Employee Sign Up',
                    fweight: FontWeight.bold,
                    color: AppColor.white,
                  )),
                  TextFieldComponent(
                    label: 'Name',
                    controller: employeeSignUpVM.name.value,
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                      label: 'Email',
                      controller: employeeSignUpVM.email.value,
                      validator: (v) {
                        final emailRegExp =
                            RegExp(r"[a-zA-Z0-9._-]+@[a-z]+\.[a-z]+");
                        if (v!.isEmpty) {
                          return "Email Required";
                        } else if (!emailRegExp
                            .hasMatch(employeeSignUpVM.email.value.text)) {
                          return "Enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFieldComponent(
                    label: 'Company Token',
                    controller: employeeSignUpVM.companyToken.value,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Token Required";
                      }
                      return null;
                    },
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                      label: 'Phone No',
                      validator: (v) {
                        final RegExp phoneRegExp = RegExp(r'^\d{11}$');
                        if (v!.isEmpty) {
                          return "phone No Required";
                        } else if (!phoneRegExp
                            .hasMatch(employeeSignUpVM.phoneNo.value.text)) {
                          return "Enter a valid phone No";
                        } else {
                          return null;
                        }
                      },
                      controller: employeeSignUpVM.phoneNo.value,
                      keyboardType: TextInputType.phone,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Obx(
                    () => TextFieldComponent(
                      label: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            employeeSignUpVM.showPass.value =
                                !employeeSignUpVM.showPass.value;
                          },
                          icon: employeeSignUpVM.showPass.value
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.remove_red_eye_outlined)),
                      controller: employeeSignUpVM.pass.value,
                      border: const OutlineInputBorder(),
                      obscureText: employeeSignUpVM.showPass.value,
                    ),
                  ),
                  verticalPadding(
                    child: Obx(
                      () => TextFieldComponent(
                        label: 'Confirm Password',
                        controller: employeeSignUpVM.passConfirm.value,
                        border: const OutlineInputBorder(),
                        obscureText: employeeSignUpVM.showPass.value,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Empty pass';
                          } else if (employeeSignUpVM.passConfirm.value.text !=
                              employeeSignUpVM.pass.value.text) {
                            return 'password not match';
                          } else if (employeeSignUpVM.pass.value.text.length <
                              6) {
                            return 'Password must be 6 or 8 Characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          employeeSignUpVM.registerEmployee(context);
                        }
                      },
                      buttonText: 'SIGN UP',
                      loading: employeeSignUpVM.loading.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
