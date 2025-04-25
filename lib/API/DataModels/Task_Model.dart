class TaskModel{

  late final String id;
  late final String title;
  late final String description;
  late final String status;
  late final String createdate;

  TaskModel.fromJson(Map<String,dynamic> jsonData){
    id=jsonData['_id'] ?? '';
    title=jsonData['title'] ?? '';
    description=jsonData['description'] ?? '';
    status=jsonData['status'] ?? '';
    createdate=jsonData['createdate'] ?? '';

  }


}