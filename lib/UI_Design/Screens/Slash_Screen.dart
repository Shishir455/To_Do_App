import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_api_app/UI_Design/Screens/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import 'package:todo_api_app/UI_Design/utils/assets_path.dart';
import '../utils/assets_path.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          ScreenBackground(
              setimage: Center(child: SvgPicture.asset(Assets_path.logo))),
        ],
      ),
    ));
  }
}
