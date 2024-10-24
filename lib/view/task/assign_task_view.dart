import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/assigntask/assigntask_view_model.dart';

class AssignTaskView extends StatefulWidget {
  const AssignTaskView({super.key, this.id});
  final String? id;
  @override
  State<AssignTaskView> createState() => _AssignTaskViewState();
}

class _AssignTaskViewState extends State<AssignTaskView> {
  AssignTaskViewModel assignTaskVM = Get.put(AssignTaskViewModel());
  // AssignTaskViewController addTaskController = Get.put(AddTaskController());
  final _formKey = GlobalKey<FormState>();
  final pref = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PageAppLogo(title: 'Add task'),
                  TextFieldComponent(
                    label: 'Task Title',
                    controller: assignTaskVM.title.value,
                    border: const OutlineInputBorder(),
                  ),
                  verticalPadding(
                    child: TextFieldComponent(
                        label: 'Describe Task',
                        controller: assignTaskVM.desc.value,
                        border: const OutlineInputBorder()),
                  ),
                  Obx(
                    () => CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          pref.getUser().then((value) =>
                              assignTaskVM.taskAssign(
                                  id: widget.id ?? value.id.toString()));
                        }
                      },
                      color: AppColor.darkBlue,
                      loading: assignTaskVM.loading.value,
                      buttonText: 'ASSIGN TASK',
                    ),
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
