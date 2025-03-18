import 'package:flutter/material.dart';
class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [],
      ),

        floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),)

    );
  }
}
