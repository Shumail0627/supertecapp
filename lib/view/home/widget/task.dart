import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view/task/taskdetail/task_details_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.msg});
  final String msg;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskViewModel taskViewModel = Get.put(TaskViewModel());
  UserPreferences preferences = UserPreferences();
  // @override
  // void initState() {
  //   super.initState();
  //   taskViewModel.taskApi();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (taskViewModel.rxRequestStatus.value) {
        case Status.LOADING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case Status.ERROR:
          return InternetExpection(
            onPressed: () {
              preferences.getUser().then((value) {
                taskViewModel.taskApi(id: value.id.toString());
              });
            },
          );
        case Status.COMPLETED:
          return ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskViewModel.taskList.length,
              itemBuilder: (context, index) {
                final data = taskViewModel.taskList;

                return data[index].taskStatus == widget.msg
                    ? ListTile(
                        onTap: () {
                          Get.to(() => AssignTask(
                                taskDetail: TaskDetail(
                                    admin: false,
                                    taskId: data[index].id,
                                    title: data[index].taskTitle,
                                    buttonText: widget.msg == "pending"
                                        ? 'Mark as Complete'
                                        : 'Completed',
                                    taskDescription:
                                        data[index].taskDescription),
                              ));
                        },
                        leading: CircleAvatar(
                          backgroundColor: widget.msg == "pending"
                              ? Colors.amber
                              : Colors.green,
                          child: const Icon(
                            Icons.pending_actions,
                            color: Colors.white,
                          ),
                        ),
                        title: TextComponent(
                            text: "Task ${data[index].taskTitle}"),
                        subtitle: TextComponent(
                            text: 'Status: ${data[index].taskStatus}'),
                        trailing: const TextComponent(
                          text: 'View',
                          color: AppColor.darkBlue,
                        ),
                      )
                    : const SizedBox.shrink();
              });
      }
    });
  }
}
