// import 'dart:developer';

import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view/task/taskdetail/task_details_view.dart';

class AdminTaskView extends StatefulWidget {
  const AdminTaskView({super.key, required this.id});
  final String? id;

  @override
  State<AdminTaskView> createState() => _AdminTaskViewState();
}

class _AdminTaskViewState extends State<AdminTaskView> {
  TaskViewModel taskViewModel = Get.put(TaskViewModel());

  @override
  void initState() {
    super.initState();
    taskViewModel.taskApi(id: widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    // log('admin task view rebuild');
    return AlertDialog(
        title: const TextComponent(text: 'View Task'),
        content: Obx(() {
          switch (taskViewModel.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              return InternetExpection(
                onPressed: () {
                  taskViewModel.taskApi(id: widget.id.toString());
                },
              );
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      List.generate(taskViewModel.taskList.length, (index) {
                    final data = taskViewModel.taskList[index];
                    return ListTile(
                      onTap: () {
                        Get.to(() => AssignTask(
                              taskDetail: TaskDetail(
                                  admin: true,
                                  taskDescription: data.taskDescription,
                                  title: data.taskTitle,
                                  buttonColor: data.taskStatus == "pending"
                                      ? Colors.red
                                      : Colors.green,
                                  buttonText: data.taskStatus),
                            ));
                      },
                      leading: CircleAvatar(
                        backgroundColor: data.taskStatus == "pending"
                            ? Colors.red
                            : Colors.green,
                        child: const Icon(
                          Icons.pending_actions,
                          color: Colors.white,
                        ),
                      ),
                      title: TextComponent(text: 'task ${data.taskTitle}'),
                      subtitle: TextComponent(text: data.taskStatus.toString()),
                      trailing: const TextComponent(text: 'View'),
                    );
                  }),
                ),
              );
          }
        }));
  }
}
