import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_api_app/UI_Design/Screens/TasksScreen/Navigator_Style_page.dart';
import 'package:todo_api_app/UI_Design/Screens/ForgetPassword.dart';
import 'package:todo_api_app/UI_Design/Screens/registration.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  final String pin = '123456';
  TextEditingController _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          setimage: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100,),
                Text('Pin Verification',style: Theme.of(context).textTheme.titleLarge,),
                const Text("A 6 digit verification pin will sent to your \nemail address",
                    style: TextStyle(fontSize: 18,color: Colors.black54,)),
                const SizedBox(height: 20),
                
                // PIN Input Field using Pinput package
                Pinput(
                  length: 6,
                  controller: _pinController,
                  obscureText: true,

                  defaultPinTheme: PinTheme(


                    width: 60,
                    height: 60,
                    textStyle: TextStyle(),decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(
                      color: Colors.white,
                    )]
          
                  )


                  ),
                  onChanged:(value) {

                  },
                  onCompleted:(value) {

                  },
                ),
                
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if(_pinController.text==pin){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Forgetpassword()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veified Successfully')));
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong')));
                    }

                  },
                  child: const Text("Verify PIN"),
                ),
                
                const SizedBox(height: 10),
                SizedBox(height: 20,),
                Center(
                  child: Column(
                    children: [
                      RichText(text: TextSpan(
                        children:[
                          TextSpan(text: 'Have Account?',style:Theme.of(context).textTheme.bodyMedium),
                          TextSpan(text: ' Sign In',style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),
                          recognizer: TapGestureRecognizer() ..onTap=(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                          })

                        ]
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
