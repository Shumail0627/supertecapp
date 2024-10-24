class UserTaskModel {
  String? id;
  String? taskTitle;
  String? taskDescription;
  String? taskStatus;

  UserTaskModel(
      {this.id, this.taskTitle, this.taskDescription, this.taskStatus});

  UserTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['task_title'];
    taskDescription = json['task_description'];
    taskStatus = json['task_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_title'] = taskTitle;
    data['task_description'] = taskDescription;
    data['task_status'] = taskStatus;
    return data;
  }
}
