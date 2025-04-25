import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

import '../../../API/utils/Urls.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool isLoading = false;
  Map<String, dynamic>? receivedEmailAndOtp;
  Massage(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
    )));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    receivedEmailAndOtp = arguments as Map<String, dynamic>;
  }

  void _togglePasswordVisibility({required bool isConfirm}) {
    setState(() {
      if (isConfirm) {
        _confirmPasswordVisible = !_confirmPasswordVisible;
      } else {
        _passwordVisible = !_passwordVisible;
      }
    });
  }

  Future<void> _Submit() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> responseBody = {
      "email": receivedEmailAndOtp!['email'],
      "OTP": receivedEmailAndOtp!['OTP'],
      "password": _password.text,
    };

    setState(() {
      isLoading = false;
    });
    NetworkClient client = NetworkClient();
    Networkresponse response = await client.postRequest(
        url: Urls.recoverResetPassword, body: responseBody);
    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/LoginPage', (predicate) => false);
      Massage(
        "Reset Password Successfully",
      );
    } else {}
  }

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ScreenBackground(
        setimage: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text('Set Password',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                const Text(
                  'Minimum length 8 characters with letter and \nnumber combination',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _password,
                  obscureText: !_passwordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _togglePasswordVisibility(isConfirm: false),
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: !_confirmPasswordVisible,
                  validator: (value) {
                    if (value != _password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _togglePasswordVisibility(isConfirm: true),
                      icon: Icon(_confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _Submit,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Confirm"),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Have an account? ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            },
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
    ));
  }
}
