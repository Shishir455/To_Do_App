import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/API/DataModels/LoginModel.dart';
import 'package:todo_api_app/UI_Design/Controller/AuthController.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/registration.dart';
import '../../../API/Service/Network_Client.dart';
import '../../../API/utils/Urls.dart';
import '../../Widgets/ScreenBackground.dart';
import '../UserTask/NewTaskScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void Massage(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
    )));
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _visiblePassword = false;

  bool isLoading = false;

  Future<void> LoginUser() async {
    Map<String, String> responseBody = {
      "email": _email.text.trim(),
      "password": _password.text
    };

    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
    NetworkClient client = NetworkClient();
    Networkresponse response =
        await client.postRequest(url: Urls.login, body: responseBody);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.body!);
      AuthController.saveInformation(loginModel.token, loginModel.userModel);

      Navigator.pushNamedAndRemoveUntil(
          context, '/NavigatorStyle', (predicate) => false);
      Massage(
        "Login Successfully",
      );
    } else {
      Massage(
        "Login Failed ",
      );
    }
  }

  _SubmitLoginUser() {
    if (_formkey.currentState!.validate()) {
      LoginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ScreenBackground(
        setimage: Padding(
          padding: const EdgeInsets.all(24),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.green,
                ))
              : Form(
                  key: _formkey,
                  child: SingleChildScrollView(
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
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter Email";
                            }
                            return null;
                          },
                          controller: _email,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(hintText: "Email"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _password,
                          obscureText: !_visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _visiblePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _visiblePassword = !_visiblePassword;
                                });
                              },
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            String password = value?.trim() ?? '';
                            RegExp regex = RegExp(
                                r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
                            if (!regex.hasMatch(password)) {
                              return 'Password must be at least 6 characters, with letters & numbers';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _SubmitLoginUser();
                              }
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
                                TextSpan(
                                    text: 'Forget Password? ',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, '/EmailVerification');
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
                                    TextSpan(
                                      text: "Don't have any account? ",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
      ),
    ));
  }
}
