import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Login_Page.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

import '../../Widgets/Validator.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool registrationInProgress = false;

  bool _visiblePassword = false;
  bool isLoading = false;
  void Massage(String massage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      massage,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
    )));
  }

  Future<void> RegistrationUser() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> responseBody = {
      "email": _email.text.trim(),
      "firstName": _firstName.text.trim(),
      "lastName": _lastName.text.trim(),
      "mobile": _mobile.text.trim(),
      "password": _password.text,
    };

    setState(() {
      isLoading = false;
    });
    NetworkClient client = NetworkClient();
    Networkresponse response =
        await client.postRequest(url: Urls.registration, body: responseBody);
    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/LoginPage', (predicate) => false);
      Massage(
        "Registration Successfully",
      );
    } else {}
  }

  _SubmitRegistration() {
    if (_formKey.currentState!.validate()) {
      RegistrationUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          setimage: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: _email,
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _firstName,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter First Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastName,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Last Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _mobile,
                      decoration: InputDecoration(hintText: 'Phone'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return validator(value!,
                            isEmptyTitle: 'Enter your Phone Number',
                            alertTitle: 'Enter a valid Phone No',
                            regExp: RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$'));
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _password,
                      decoration: InputDecoration(hintText: 'Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return validator(value!,
                            isEmptyTitle: 'Enter your Password',
                            alertTitle: 'Enter a valid Password',
                            regExp: RegExp(
                                r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$'));
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton.icon(
                            onPressed: _SubmitRegistration,
                            icon: const Icon(Icons.arrow_circle_right),
                            label: const Text("Register"),
                          ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: 'Have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (pre) => false,
                                  );
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
        ),
      ),
    );
  }
}
