import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

import '../../../API/utils/Urls.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => Pin_Verification();
}

class Pin_Verification extends State<PinVerification> {
  Message(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
    )));
  }

  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argument = ModalRoute.of(context)!.settings.arguments;
    receivedEmail = argument as String;
  }

  bool isLoading = false;
  String? receivedEmail;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _VerifyOTP() async {
    final String otp = _pinController.text;

    isLoading = true;
    setState(() {});

    String url = Urls.recoverVerifyOtp(receivedEmail!, otp);
    Networkresponse response = await NetworkClient().getRequest(url: url);
    if (!mounted) return;

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/ForgetPass',
        (route) => false,
        arguments: {'email': receivedEmail, 'OTP': _pinController.text},
      );
      return;
    } else {
      Message("Invalid OTP");
    }
    isLoading = false;
  }

  _onTapSubmit() {
    if (_formKey.currentState!.validate() == true) {
      _VerifyOTP();
    }
  }

  void _goToLogin() {
    Navigator.pushNamed(context, '/LoginPage');
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

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
                const SizedBox(height: 100),
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const Text(
                  "A 6-digit verification pin has been sent to your email address",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Pinput(
                    length: 6,
                    controller: _pinController,
                    validator: (String? value) {
                      if (value!.trim().isEmpty == true) {
                        return 'Please Provide your OTP';
                      } else if (value.trim().length < 6) {
                        return 'Provide valid OTP';
                      }
                      return null;
                    },
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(fontSize: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _onTapSubmit,
                        child: const Text("Verify PIN"),
                      ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _goToLogin,
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
    );
  }
}
