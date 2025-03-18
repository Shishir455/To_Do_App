import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/API/API_Connection.dart';
import 'package:todo_api_app/UI_Design/Screens/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
 final TextEditingController _email = TextEditingController();
  final TextEditingController _FirstName = TextEditingController();
  final  TextEditingController _LastName = TextEditingController();
  final TextEditingController _Mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _Formkey = GlobalKey<FormState>();
  Map<String,String> FromValues = {"email":"email",
    "firstName":"firstName",
    "lastName":"lastName",
    "mobile":"mobile",
    "password":"password",
    };
  bool isLoading =false;

  InputOnchange(Mapkey,Textvalue)async{
    setState(() {
      FromValues.update(Mapkey, (value)=>Textvalue);
    });

  }
  FromSubmit()async{
    if(FromValues["email"]!.length==0){
      return "Email Required";
    }
    else if(FromValues["firstName"]!.length==0){
      return "firstName Required";
    }
    else if(FromValues["lastName"]!.length==0){
      return "lastName Required";
    }
    else if(FromValues["mobile"]!.length==0){
      return "mobile Required";
    }
    else if(FromValues["password"]!.length<=8){
      return "Password Must be 8 characters";
    }
    setState(() {
      isLoading=true;
    });
    bool res =await API_Connection().Registration(FromValues);
    if(res == true){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (pre)=> false,);


    }
    setState(() {
      isLoading=false;
    });

  }


  void dispose(){
    _email.dispose();
    _FirstName.dispose();
    _LastName.dispose();
    _Mobile.dispose();
    _password.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
            setimage: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _Formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged:(value)=>InputOnchange("email",value),
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged:(value)=>InputOnchange("firstName", value),
                    controller: _FirstName,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged:(value)=>InputOnchange("lastName", value),
                    controller: _LastName,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged:(value)=>InputOnchange("mobile",value),
                    controller: _Mobile,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged:(value)=>InputOnchange("password",value),
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
              
                  ElevatedButton(
                      onPressed: () {
                        FromSubmit();

                      },
                      child: Icon(
              
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                        size: 20,
                      )),
                  SizedBox(height: 20,),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(text: 'Have an account?',style: Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                  text: 'Sign In ',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.green
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (pre)=> false,);
                        },
                                    ),
                            ])),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
