import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_api_app/API/DataModels/TaskStatusCountListModel.dart';
import 'package:todo_api_app/API/DataModels/TaskStatusCountModel.dart';
import 'package:todo_api_app/API/DataModels/Task_List_Model.dart';
import 'package:todo_api_app/API/DataModels/Task_Model.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/AddTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Widgets/AllScreenCard.dart';
import 'package:todo_api_app/UI_Design/Widgets/App_Bar.dart';
import 'package:todo_api_app/UI_Design/Widgets/CrudTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import '../../Widgets/CrudTaskScreenMethod.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
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

  List<TaskStatusCountModel> _taskStatusCountList = [];
  bool isLoading = false;
  List<TaskModel> _NewTaskList = [];
  bool isTaskLoading = false;

  Future<void> _getStatusCount() async {
    setState(() {
      isLoading = true;
    });

    Networkresponse response =
        await NetworkClient().getRequest(url: Urls.taskStatusCount);

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      try {
        TaskStatusCountListModel model =
            TaskStatusCountListModel.fromJson(response.body ?? {});
        setState(() {
          _taskStatusCountList = model.statusCount ?? [];
        });
      } catch (e) {
        showMessage("Parsing Error: ${e.toString()}");
      }
    } else {
      showMessage("Status Count Failed");
    }
  }

  Future<void> _getTaskShow() async {
    setState(() {
      isTaskLoading = true;
    });

    Networkresponse response =
        await NetworkClient().getRequest(url: Urls.listTaskByStatus('New'));

    setState(() {
      isTaskLoading = false;
    });

    if (response.isSuccess) {
      try {
        TaskListModel model = TaskListModel.fromJson(response.body ?? {});
        setState(() {
          _NewTaskList = model.taskList ?? [];
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
    _getStatusCount();
    _getTaskShow();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: App_Bar(),
        body: ScreenBackground(
          setimage: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrudTaskScreenMethod(context),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _taskStatusCountList.isEmpty
                        ? const Center(child: Text('No Status Count Available'))
                        : SizedBox(
                            height: 120,
                            width: 500,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _taskStatusCountList.length,
                              itemBuilder: (context, index) {
                                return CrudTaskScreen(
                                  tittle: _taskStatusCountList[index].status!,
                                  number:
                                      _taskStatusCountList[index].statusCount!,
                                );
                              },
                            ),
                          ),
                isTaskLoading
                    ? SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()))
                    : _NewTaskList.isEmpty
                        ? const Center(child: Text('No Tasks Available'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _NewTaskList.length,
                            itemBuilder: (context, index) {
                              return AllScreenCard(
                                dateTime: DateTime
                                    .now(), // You can use _taskModel[index].createdate if parsed correctly
                                status: _NewTaskList[index].status,
                                title: _NewTaskList[index].title,
                                subtitle: _NewTaskList[index].description,
                                color: Colors.blue,
                                taskId: _NewTaskList[index].id,
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Addtaskscreen()),
            );
          },
          child: Image.network(
            'https://img.icons8.com/fluent/512w/add-to-clipboard.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
