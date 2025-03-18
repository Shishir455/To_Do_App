import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Screens/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Screens/registration.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';
import '../../API/API_Connection.dart';
import 'ForgetPassword.dart';
import 'Pin_Verification.dart';

class ForgetpasswordVerifyEmail extends StatefulWidget {
  const ForgetpasswordVerifyEmail({super.key});

  @override
  State<ForgetpasswordVerifyEmail> createState() => _ForgetpasswordVerifyEmailState();
}

class _ForgetpasswordVerifyEmailState extends State<ForgetpasswordVerifyEmail> {
  @override
  final _formkey = GlobalKey<FormState>();


  final TextEditingController _email = TextEditingController();
  Map <String,String> Forgetpassword = {"email" :"email"};
  bool isloading = false;
  OnstateChange(Mapvalue,TextValue){
    setState(() {
      Forgetpassword.update(Mapvalue, (value)=>TextValue);

    });
  }
  Fromstate(FromValues)async {
    if (FromValues['email']!.length == 0) {
      return "Filled Email Address";
    }
    else {
      setState(() {
        isloading = true;
      });
      bool res = await API_Connection().EmailVerification(FromValues);
      if (res == true) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => PinVerification()));
      }
      setState(() {
        isloading = false;
      });
    }
  }


  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: ScreenBackground(
            setimage: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      'Email Address ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'A 6 digit verification will send in your email  ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith( color: Colors.grey),


                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged:(value)=>OnstateChange("email", value),
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    ElevatedButton(
                        onPressed: () {
                          Fromstate(Forgetpassword);

                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                          size: 24,
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(children: [

                              ])),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(text: "Don't have any account? "),
                                    TextSpan(
                                        text: 'Sign In',
                                        style: TextStyle(color: Colors.green),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          }),
                                  ]))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
