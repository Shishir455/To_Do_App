import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/AddTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/CancelTasks.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/CompletedTask.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/EmailVerification.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/ForgetPassword.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Navigator_Style_page.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/NewTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Pin_Verification.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/ProgressTask.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/Slash_Screen.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/registration.dart';


class Task extends StatelessWidget {

  const Task ({super.key

  });

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(


      routes: {
        '/SlashScreen':(context)=>SlashScreen(),
        '/LoginPage':(context)=>LoginPage(),
        '/Registration':(context)=>Registration(),
        '/NewTaskScreen':(context)=>Newtaskscreen(),
        '/AddNewTask':(context)=>Addtaskscreen(),
        '/CencelTask':(context)=>CancledTask(),
        '/ForgetPass':(context)=>Forgetpassword(),
        '/EmailVerification':(context)=>EmailVerification(),
        '/PinVerification': (context)=>PinVerification(),
        '/Completetask':(context)=>CompletedTask(),
        '/NavigatorStyle':(context)=>NavigatorStyle(),
        '/ProgressTaskScreen':(context)=>ProgressTask()

      },
      theme:  ThemeData(

        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(height: 2),
            border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),



        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
             fixedSize:const Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30),
          bodyMedium: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade50,
          toolbarHeight: 70,
          elevation: 10,
          shadowColor: Colors.blue.shade900,

        ),
      ),


      home: SlashScreen(),
      debugShowCheckedModeBanner: false,


    );

    }

  OutlineInputBorder  _getZeroBorder(){
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}
