import 'TaskStatusCountModel.dart';

class TaskStatusCountListModel {
  List<TaskStatusCountModel>? statusCount;

  TaskStatusCountListModel({this.statusCount});

  TaskStatusCountListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      statusCount = <TaskStatusCountModel>[];
      json['data'].forEach((v) {
        statusCount!.add(TaskStatusCountModel.fromJson(v));
      });
    }
  }
}
