class CheckoutModel {
  List<TaskMessages>? taskMessages;
  bool? error;
  String? already;
  String? message;
  String? name;

  CheckoutModel(
      {this.taskMessages, this.error, this.already, this.message, this.name});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    if (json['task_messages'] != null) {
      taskMessages = <TaskMessages>[];
      json['task_messages'].forEach((v) {
        taskMessages!.add(TaskMessages.fromJson(v));
      });
    }
    error = json['Error'];
    already = json['already'];
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskMessages != null) {
      data['task_messages'] = taskMessages!.map((v) => v.toJson()).toList();
    }
    data['Error'] = error;
    data['already'] = already;
    data['message'] = message;
    data['name'] = name;
    return data;
  }
}

class TaskMessages {
  String? taskComment;

  TaskMessages({this.taskComment});

  TaskMessages.fromJson(Map<String, dynamic> json) {
    taskComment = json['task_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_comment'] = taskComment;
    return data;
  }
}
