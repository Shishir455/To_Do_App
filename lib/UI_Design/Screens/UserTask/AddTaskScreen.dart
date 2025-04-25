import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/NewTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Widgets/App_Bar.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

import '../../../API/Service/Network_Client.dart';
import '../../../API/utils/Urls.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  final TextEditingController _TaskName = TextEditingController();
  final TextEditingController _TaskDescription = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  void _onSubmitButton() {
    if (_formkey.currentState!.validate()) {
      AddTaskUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Newtaskscreen()),
      );
    }
  }

  void Massage(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
    )));
  }

  Future<void> AddTaskUser() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> responseBody = {
      "title": _TaskName.text.trim(),
      "description": _TaskDescription.text.trim(),
      "status": "New",
    };

    NetworkClient client = NetworkClient();
    Networkresponse response = await client.postRequest(
      url: Urls.createTask,
      body: responseBody,
    );

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      Massage("Task Added Successfully");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/NavigatorStyle',
        (predicate) => false,
      );
    } else {
      Massage('Something Went Wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: App_Bar(),
        body: ScreenBackground(
          setimage: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      "Add Task's",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _TaskName,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Task Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Task's Name",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _TaskDescription, // ✅ fixed controller here
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Task Description';
                        }
                        return null;
                      },
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _onSubmitButton,
                      child: Text("Add Task's"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
