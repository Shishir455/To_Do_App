import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_api_app/UI_Design/Controller/AuthController.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Navigator_Style_page.dart';
import 'package:todo_api_app/UI_Design/Screens/UserTask/NewTaskScreen.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import 'package:todo_api_app/UI_Design/utils/assets_path.dart';
class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movetoNextScreen();
    });
  }

  Future<void> _movetoNextScreen() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final bool isLoggedIn = await AuthController.checkLoginStatus();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => isLoggedIn ? NavigatorStyle() : LoginPage()),
      );
    } catch (e) {
      print("Error in splash navigation: $e");
      // Fallback to login in case of error
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ScreenBackground(
              setimage: Center(child: SvgPicture.asset(Assets_path.logo)),
            ),
          ],
        ),
      ),
    );
  }
}
