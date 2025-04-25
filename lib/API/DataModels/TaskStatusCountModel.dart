class TaskStatusCountModel {
  String? status;
  int? statusCount;

  TaskStatusCountModel({this.status, this.statusCount});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['_id'];
    statusCount = json['sum'];
  }
}
