import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_api_app/API/DataModels/UseerModel.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';
import 'package:todo_api_app/UI_Design/Controller/AuthController.dart';
import 'package:todo_api_app/UI_Design/Widgets/App_Bar.dart';
import 'package:todo_api_app/UI_Design/Widgets/ScreenBackground.dart';

class UpdateProfile extends StatefulWidget {
  final VoidCallback? onProfileUpdated;

  const UpdateProfile({Key? key, this.onProfileUpdated}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    final userModel = AuthController.userModel;
    _emailController.text = userModel?.email ?? '';
    _firstNameController.text = userModel?.firstName ?? '';
    _lastNameController.text = userModel?.lastName ?? '';
    _mobileController.text = userModel?.mobile ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final Map<String, String> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      requestBody["password"] = _passwordController.text;
    }

    if (_selectedImage != null) {
      final imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    try {
      final response = await NetworkClient().postRequest(
        url: Urls.profileUpdate,
        body: requestBody,
      );

      if (response.isSuccess) {
        final updatedUser = UserModel(
          email: _emailController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobile: _mobileController.text.trim(),
          photo: requestBody['photo'] ?? AuthController.userModel?.photo,
        );

        await AuthController.updateUserData(updatedUser);

        if (widget.onProfileUpdated != null) {
          widget.onProfileUpdated!();
        }

        Navigator.pop(context);
        _showMessage("Profile Updated Successfully");
      } else {
        _showMessage("Profile Update Failed");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = AuthController.userModel;

    return Scaffold(
      appBar: App_Bar(isProfileScreen: true),
      body: ScreenBackground(
        setimage: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (userModel?.photo != null &&
                              userModel!.photo!.isNotEmpty)
                              ? MemoryImage(base64Decode(userModel.photo!))
                              : const NetworkImage(
                              "http://i2.wp.com/www.marismith.com/wp-content/uploads/2014/07/facebook-profile-blank-face.jpeg")
                          as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    enabled: false,
                    controller: _emailController,
                    validator: (value) =>
                    value!.isEmpty ? "Enter Email" : null,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (value) =>
                    value!.isEmpty ? "Enter First Name" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: (value) =>
                    value!.isEmpty ? "Enter Last Name" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      final phone = value?.trim() ?? '';
                      final regex = RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$');
                      return regex.hasMatch(phone)
                          ? null
                          : 'Enter Valid Mobile No';
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text("Update Profile"),
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

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}