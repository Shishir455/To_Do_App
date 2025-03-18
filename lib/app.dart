import 'package:flutter/material.dart';
import 'UI_Design/Screens/Slash_Screen.dart';

class Task extends StatelessWidget {
  const Task ({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(
        colorSchemeSeed: Colors.grey,
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
          backgroundColor: Colors.green,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: Colors.black54,

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
