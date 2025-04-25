import 'package:flutter/material.dart';

import 'package:todo_api_app/UI_Design/Screens/UserTask/CancelTasks.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/CompletedTask.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/NewTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/ProgressTask.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import '../../Widgets/App_Bar.dart';

class NavigatorStyle extends StatefulWidget {
  const NavigatorStyle({super.key});

  @override
  State<NavigatorStyle> createState() => _NavigatorStyleState();
}

class _NavigatorStyleState extends State<NavigatorStyle> {
  int _currenIndex = 0;
  List<Widget> _screens = [
    Newtaskscreen(),
    ProgressTask(),
    CancledTask(),
    CompletedTask(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: App_Bar(Api: '',),
        body: _screens[_currenIndex],
        bottomNavigationBar: NavigationBar(
            selectedIndex: _currenIndex,
            onDestinationSelected: (index) {
              _currenIndex = index;
              setState(() {});
            },
            destinations: [
              NavigationDestination(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/906/906334.png',
                    fit: BoxFit.contain,
                  ),
                ),
                label: 'New Task',
              ),
              NavigationDestination(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.network(
                    'https://cdn.vectorstock.com/i/500p/60/81/task-progress-check-icon-vector-55196081.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                label: 'Progress Task',
              ),
              NavigationDestination(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/5387/5387010.png',
                    fit: BoxFit.contain,
                  ),
                ),
                label: 'Cancel Task',
              ),
              NavigationDestination(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.network(
                    'https://thumbs.dreamstime.com/b/task-completed-vector-icon-isolated-white-background-83422757.jpg', // Replace with a suitable URL for Complete Task
                    fit: BoxFit.contain,
                  ),
                ),
                label: 'Complete Task',
              ),
            ]));
  }
}
