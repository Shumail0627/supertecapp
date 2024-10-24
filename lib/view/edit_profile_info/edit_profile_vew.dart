import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/edit_profile/edit_profile_view_model.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  final updateInfo = Get.put(EditProfileViewModel());
  // final FocusNode focusfatherName = FocusNode();
  // final FocusNode focuscnic = FocusNode();
  // final FocusNode focusdob = FocusNode();
  // final FocusNode focushomeAddress = FocusNode();
  // final FocusNode focuscompany = FocusNode();
  // final FocusNode focusdoj = FocusNode();

  // @override
  // void dispose() {
  //   focusfatherName.dispose();
  //   focuscnic.dispose();
  //   focusdob.dispose();
  //   focushomeAddress.dispose();
  //   focuscompany.dispose();
  //   focusdoj.dispose();
  //   super.dispose();
  // }

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
                    text: 'Update Profile Info',
                    fweight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  )),
                  TextFieldComponent(
                    label: 'Father\'s Name',
                    // onEditingComplete: true,
                    // focusOver: focusfatherName,
                    // nextfocus: focuscnic,
                    controller: updateInfo.fatherName.value,
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                      // onEditingComplete: true,
                      // focusOver: focuscnic,
                      // nextfocus: focusdob,
                      label: 'CNIC Number',
                      controller: updateInfo.cnicNumber.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CNIC';
                        }
                        final cnicRegex = RegExp(r'^\d{5}\d{7}\d{1}$');
                        if (!cnicRegex.hasMatch(value)) {
                          return 'Invalid CNIC format no need to add -';
                        }
                        return null;
                      },
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFieldComponent(
                    // focusOver: focusdob,
                    // onEditingComplete: true,
                    // nextfocus: focushomeAddress,
                    label: 'Date of Birth',
                    controller: updateInfo.dateOfBirth.value,
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                      // focusOver: focushomeAddress,
                      // onEditingComplete: true,
                      // nextfocus: focuscompany,
                      label: 'Home Address',
                      controller: updateInfo.homeAddress.value,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  TextFieldComponent(
                    label: 'Department/Company',
                    controller: updateInfo.departmentCompany.value,
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                      // focusOver: focusdoj,
                      // onEditingComplete: true,
                      label: 'Date of Joining',
                      controller: updateInfo.dateOfJoining.value,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateInfo.editProfile();
                      }
                    },
                    color: AppColor.darkBlue,
                    buttonText: 'SUBMIT',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
