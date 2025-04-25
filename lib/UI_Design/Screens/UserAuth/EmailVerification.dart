import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

import '../../../API/utils/Urls.dart';
import '../../Widgets/Validator.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        setimage: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    'Your Email Address',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'A 6 digit pin verification will be sent to your email address',
                    style: TextTheme.of(context).labelLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      return validator(
                        value!,
                        isEmptyTitle: 'Enter your mail address',
                        alertTitle: 'Enter a valid mail',
                        regExp: RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _onTapSubmit,
                    child: Visibility(
                      visible: isLoading == false,
                      replacement: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircularProgressIndicator(),
                      ),
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Already Have an Account?'),
                          TextSpan(
                            text: ' Sign in',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapSubmit() {
    if (_formKey.currentState!.validate() == true) {
      _pinVerify();
    }
  }

  Future<void> _pinVerify() async {
    isLoading = true;
    setState(() {});
    String email = _emailTEController.text.trim();

    String url = Urls.recoverVerifyEmail(email);

    Networkresponse response = await NetworkClient().getRequest(url: url);
    if (response.statusCode == 200) {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/PinVerification',
        (route) => false,
        arguments: email,
      );
    } else {
      isLoading = false;
      setState(() {});
      if (!mounted) return;
      Massage("Email Not Found");
    }
    isLoading = false;
    setState(() {});
  }

  _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  Massage(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
    )));
  }
}
