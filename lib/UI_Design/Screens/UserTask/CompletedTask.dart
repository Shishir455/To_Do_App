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

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
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

  List<TaskModel> _CompletedTaskModel = [];
  bool isTaskLoading = false;

  Future<void> _getTaskShow() async {
    setState(() {
      isTaskLoading = true;
    });

    Networkresponse response = await NetworkClient()
        .getRequest(url: Urls.listTaskByStatus('Completed'));

    setState(() {
      isTaskLoading = false;
    });

    if (response.isSuccess) {
      try {
        TaskListModel model = TaskListModel.fromJson(response.body ?? {});
        setState(() {
          _CompletedTaskModel = model.taskList ?? [];
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
              : _CompletedTaskModel.isEmpty
                  ? const Center(child: Text('No Tasks Available'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _CompletedTaskModel.length,
                      itemBuilder: (context, index) {
                        return AllScreenCard(
                          dateTime: DateTime
                              .now(), // You can use _taskModel[index].createdate if parsed correctly
                          status: _CompletedTaskModel[index].status,
                          title: _CompletedTaskModel[index].title,
                          subtitle: _CompletedTaskModel[index].description,
                          color: Colors.green,
                          taskId: _CompletedTaskModel[index].id,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
