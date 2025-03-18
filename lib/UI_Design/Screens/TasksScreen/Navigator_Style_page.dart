import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Screens/TasksScreen/NewTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import '../../Widgets/App_Bar.dart';

class Navigator_Style_page extends StatefulWidget {
  const Navigator_Style_page({super.key});

  @override
  State<Navigator_Style_page> createState() => _Navigator_Style_pageState();
}

class _Navigator_Style_pageState extends State<Navigator_Style_page> {
  int _currenIndex = 0;
  List<Widget> _screens = [
    Newtaskscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(),
      body: ScreenBackground(setimage: _screens[_currenIndex]),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currenIndex,
          onDestinationSelected: (index) {
            _currenIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined), label: 'New Task'),
            NavigationDestination(
                icon: Icon(Icons.incomplete_circle), label: 'Completed Task'),
            NavigationDestination(
                icon: Icon(Icons.add_task), label: 'Progress Task'),
            NavigationDestination(
                icon: Icon(Icons.delete), label: 'Cencle Task'),
          ]),
    );
  }
}
