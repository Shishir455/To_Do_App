import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/API/API_Connection.dart';
import 'package:todo_api_app/UI_Design/Screens/TasksScreen/Navigator_Style_page.dart';
import 'package:todo_api_app/UI_Design/Screens/EmailVerification.dart';
import 'package:todo_api_app/UI_Design/Screens/registration.dart';
import '../Widgets/ScreenBackground.dart';
import 'TasksScreen/NewTaskScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _visiblePassword = false;
  Map<String,String> FromValue = {"email": "email","password":"password"};
  bool isLoading = false;
  InputOnchange(Mapkey,Textvalue){
    setState(() {
      FromValue.update(Mapkey, (value)=>Textvalue);

    });
  }
  FormSubmit() async{

    if(FromValue['email']!.length==0){
      return "email Required";
    }
    else if(FromValue['password']!.length==0){
      return "password Required";
    }
    else {
      setState(() {
        isLoading=true;
      });
      bool res=  await API_Connection().LoginPage(FromValue);
      if(res == true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Newtaskscreen()));
      }
      isLoading=false;
    }
  }

  @override
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
                      'Get Statrted With ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "Email"),
                      onChanged:(value)=>InputOnchange("email", value),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged:(value)=>InputOnchange("password", value),
                      controller: _password,
                      textInputAction: TextInputAction.next,
                      obscureText: !_visiblePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              _visiblePassword=!_visiblePassword;
                            });

                          }, icon: Icon(_visiblePassword? Icons.visibility : Icons.visibility_off))
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: (){FormSubmit();},
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
                                TextSpan(
                                    text: 'Forget Password? ',
                                    style:TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetpasswordVerifyEmail()));
                                      }),
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
                                    TextSpan(text: "Don't have any account? ",style:TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Registration()));
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