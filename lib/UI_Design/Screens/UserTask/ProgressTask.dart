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

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
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

  List<TaskModel> _progresstaskModel = [];
  bool isTaskLoading = false;

  Future<void> _getTaskShow() async {
    setState(() {
      isTaskLoading = true;
    });

    Networkresponse response = await NetworkClient()
        .getRequest(url: Urls.listTaskByStatus('Progress'));

    setState(() {
      isTaskLoading = false;
    });

    if (response.isSuccess) {
      try {
        TaskListModel model = TaskListModel.fromJson(response.body ?? {});
        setState(() {
          _progresstaskModel = model.taskList ?? [];
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
    // _getStatusCount();
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
              : _progresstaskModel.isEmpty
                  ? const Center(child: Text('No Tasks Available'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _progresstaskModel.length,
                      itemBuilder: (context, index) {
                        return AllScreenCard(
                          dateTime: DateTime
                              .now(), // You can use _taskModel[index].createdate if parsed correctly
                          status: _progresstaskModel[index].status,
                          title: _progresstaskModel[index].title,
                          subtitle: _progresstaskModel[index].description,
                          color: Colors.orange,
                          taskId: _progresstaskModel[index].id,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
