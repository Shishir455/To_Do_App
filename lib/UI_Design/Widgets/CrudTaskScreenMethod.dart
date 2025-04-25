import 'package:flutter/cupertino.dart';
import 'package:todo_api_app/API/DataModels/Task_Model.dart';
import 'CrudTaskScreen.dart';

SingleChildScrollView CrudTaskScreenMethod(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        // CrudTaskScreen(tittle: "New", number: 10),
        // CrudTaskScreen(tittle: 'Progress', number: 12),
        // CrudTaskScreen(tittle: 'Cancle', number: 12),
        // CrudTaskScreen(tittle: 'Completed', number: 1),
      ],
    ),
  );
}
