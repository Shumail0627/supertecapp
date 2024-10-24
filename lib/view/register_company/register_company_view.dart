import '../../utils/new_all_imports.dart';
import '../../view_models/controller/register_company/resgister_company_view_model.dart';

class ResgisterCompanyView extends StatefulWidget {
  const ResgisterCompanyView({super.key});

  @override
  State<ResgisterCompanyView> createState() => _ResgisterCompanyViewState();
}

class _ResgisterCompanyViewState extends State<ResgisterCompanyView> {
  final resgisterVM = Get.put(RegisterCompanyViewModel());

  final _formkey = GlobalKey<FormState>();

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
                      const PageAppLogo(title: 'Register Company/Office'),
                      TextFieldComponent(
                          textSize: 14,
                          label: 'Company Name',
                          controller: resgisterVM.companyName.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      verticalPadding(
                        child: TextFieldComponent(
                            textSize: 14,
                            label: 'Company Email',
                            validator: emailValidation,
                            controller: resgisterVM.companyEmail.value,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      TextFieldComponent(
                          textSize: 14,
                          label: 'Company Token',
                          controller: resgisterVM.companyToken.value,
                          suffixIcon: TextButton(
                              onPressed: () {
                                resgisterVM.generateCompanyToken(7);
                              },
                              child: const TextComponent(text: 'Generate')),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      verticalPadding(
                        child: Obx(
                          () => TextFieldComponent(
                              label: 'Password',
                              textSize: 14,
                              obscureText: resgisterVM.showPass.value,
                              validator: fieldValidator,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    resgisterVM.showPass.value =
                                        !resgisterVM.showPass.value;
                                  },
                                  icon: resgisterVM.showPass.value
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(
                                          Icons.remove_red_eye_outlined)),
                              controller: resgisterVM.companyPass.value,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      verticalPadding(
                          child: CustomButton(
                        onPressed: () => resgisterVM.register(),
                        buttonText: 'REGISTER',
                        loading: resgisterVM.loading.value,
                      )),
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
