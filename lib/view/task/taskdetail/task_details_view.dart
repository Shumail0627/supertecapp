import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/task/taskdetails/task_details_view_model.dart';

class AssignTask extends StatefulWidget {
  const AssignTask({super.key, required this.taskDetail});
  final TaskDetail taskDetail;

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  TaskUpdateViewModel taskUpdateVM = Get.put(TaskUpdateViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalPadding(
                      child: TextComponent(
                    text: widget.taskDetail.title.toString(),
                    fweight: FontWeight.bold,
                    size: 23,
                  )),
                  TextComponent(
                    text: widget.taskDetail.taskDescription.toString(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: widget.taskDetail.admin!
                ? CustomButton(
                    onPressed: () {},
                    radius: 0,
                    color: widget.taskDetail.buttonColor,
                    buttonText: widget.taskDetail.buttonText.toString(),
                  )
                : Obx(
                    () => CustomButton(
                      onPressed: taskUpdateVM.buttonText.value ==
                              "Mark as Complete"
                          ? widget.taskDetail.buttonText == "Mark as Complete"
                              ? () {
                                  taskUpdateVM.taskCompleteCheckApi(
                                      widget.taskDetail.taskId);
                                }
                              : () {}
                          : () {},
                      radius: 0,
                      color: taskUpdateVM.buttonText.value == "Completed"
                          ? Colors.green
                          : Colors.black,
                      buttonText: widget.taskDetail.buttonText ??
                          taskUpdateVM.buttonText.value,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class TaskDetail {
  String? taskId;
  String? title;
  bool? admin = false;
  String? taskDescription;
  String? buttonText;
  Color? buttonColor;
  TaskDetail(
      {this.taskId,
      required this.title,
      required this.admin,
      this.buttonColor,
      this.buttonText,
      required this.taskDescription});
}
