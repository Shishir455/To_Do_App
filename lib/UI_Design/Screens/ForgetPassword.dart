import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Screens/TasksScreen/Navigator_Style_page.dart';
import 'package:todo_api_app/UI_Design/Screens/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Screens/registration.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  bool _isvisiblepassword=false;
  final TextEditingController _password= TextEditingController();
  final TextEditingController _confirmPassword= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ScreenBackground(
          setimage: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Set Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Minimum length 8 characters with letter and \nnumber combination',style: TextStyle(color: Colors.black54,fontSize: 16),),
            SizedBox(height: 20,),
            TextFormField(
              controller: _password,
              obscureText: !_isvisiblepassword,
              decoration: InputDecoration(hintText: 'Password'
              ,suffixIcon: IconButton(onPressed: (){
                setState(() {
                  _isvisiblepassword=!_isvisiblepassword;
                });

                  }, icon: Icon(_isvisiblepassword? Icons.visibility : Icons.visibility_off))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _confirmPassword,
              obscureText: !_isvisiblepassword,
              decoration: InputDecoration(hintText: 'Confirm Password',
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  _isvisiblepassword=! _isvisiblepassword;
                });
              }, icon: Icon(_isvisiblepassword? Icons.visibility : Icons.visibility_off))),
            ),
           
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Confirm")),
            SizedBox(height: 20,),
            Center(
              child: Column(
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Have an account?',style: Theme.of(context).textTheme.bodyMedium
                      ),
                      TextSpan(text: ' Sign In',style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),
                          recognizer: TapGestureRecognizer() ..onTap=(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          })
                    ]
                  )),
                ],
              ),
            )
          ],
        ),
      )),
    ));
  }
}
