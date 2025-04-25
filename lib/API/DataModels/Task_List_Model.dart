import 'package:todo_api_app/API/DataModels/Task_Model.dart';

class TaskListModel {
  String status;
  List<TaskModel>? taskList;

  TaskListModel({
    required this.status,
    this.taskList,
  });

  // Fix: Correctly implement the fromJson method
  TaskListModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] ?? '', // Assuming 'status' is a required field
        taskList = (json['data'] != null)
            ? (json['data'] as List).map((v) => TaskModel.fromJson(v)).toList()
            : null;
}
