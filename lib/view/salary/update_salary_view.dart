// import 'dart:developer';

import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/salary/updatesalary_view_model.dart';

class UpdateSalaryView extends StatefulWidget {
  const UpdateSalaryView({super.key, required this.id});
  final String id;
  @override
  State<UpdateSalaryView> createState() => _UpdateSalaryViewState();
}

class _UpdateSalaryViewState extends State<UpdateSalaryView> {
  final updateSalaryVM = Get.put(UpdateSalaryViewModel());
  @override
  Widget build(BuildContext context) {
    // log('rebuild salary page');
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalPadding(child: const PageAppLogo(title: 'Update Salary')),
              Obx(
                () => TextComponent(
                    text: updateSalaryVM.salary.value.toString(),
                    fweight: FontWeight.bold,
                    size: 30),
              ),
              Obx(
                () => TextFieldComponent(
                  label: 'Update Salary',
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    updateSalaryVM.salary.value = v;
                  },
                  controller: updateSalaryVM.salaryController.value,
                  border: const UnderlineInputBorder(),
                ),
              ),
              verticalPadding(
                child: CustomButton(
                  onPressed: () {
                    updateSalaryVM.updateSalary(id: widget.id);
                    // Api.UpdateSalaryView(salaryController.text.trim(), widget.id)
                    // .whenComplete(() => Get.back());
                  },
                  color: Colors.blue,
                  buttonText: 'Update Salary',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
