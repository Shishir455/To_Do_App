import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_api_app/API/DataModels/TaskStatusCountListModel.dart';
import 'package:todo_api_app/API/DataModels/TaskStatusCountModel.dart';
import 'package:todo_api_app/API/DataModels/Task_List_Model.dart';
import 'package:todo_api_app/API/DataModels/Task_Model.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';
import 'package:todo_api_app/UI_Design/Widgets/AllScreenCard.dart';
import 'package:todo_api_app/UI_Design/Widgets/App_Bar.dart';

import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

class CancledTask extends StatefulWidget {
  const CancledTask({super.key});

  @override
  State<CancledTask> createState() => _CancledTaskState();
}

class _CancledTaskState extends State<CancledTask> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.red),
        ),
      ),
    );
  }

  List<TaskModel> _CancledTaskModel = [];
  bool isTaskLoading = false;

  Future<void> _getTaskShow() async {
    setState(() {
      isTaskLoading = true;
    });

    Networkresponse response =
        await NetworkClient().getRequest(url: Urls.listTaskByStatus('Cancled'));

    setState(() {
      isTaskLoading = false;
    });

    if (response.isSuccess) {
      try {
        TaskListModel model = TaskListModel.fromJson(response.body ?? {});
        setState(() {
          _CancledTaskModel = model.taskList ?? [];
        });
      } catch (e) {
        showMessage("Parsing Error: ${e.toString()}");
      }
    } else {
      showMessage("Task List Failed");
    }
  }

  @override
  void initState() {
    super.initState();
    _getTaskShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(),
      body: ScreenBackground(
        setimage: Expanded(
          child: isTaskLoading
              ? const Center(child: CircularProgressIndicator())
              : _CancledTaskModel.isEmpty
                  ? const Center(child: Text('No Tasks Available'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _CancledTaskModel.length,
                      itemBuilder: (context, index) {
                        return AllScreenCard(
                          dateTime: DateTime
                              .now(), // You can use _taskModel[index].createdate if parsed correctly
                          status: _CancledTaskModel[index].status,
                          title: _CancledTaskModel[index].title,
                          subtitle: _CancledTaskModel[index].description,
                          color: Colors.green,
                          taskId: _CancledTaskModel[index].id,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
