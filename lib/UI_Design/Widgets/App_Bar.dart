import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_api_app/UI_Design/Controller/AuthController.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/Update_Profile.dart';
import 'package:todo_api_app/UI_Design/Screens/UserAuth/UserProfile.dart';

class App_Bar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProfileScreen;
  final VoidCallback? onProfileUpdated;

  const App_Bar({
    this.isProfileScreen = false,
    this.onProfileUpdated,
    Key? key,
  }) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await AuthController.logout();
    Navigator.pushNamedAndRemoveUntil(
        context,
        '/LoginPage',
            (route) => false
    );
  }

  bool _shouldShowPhoto(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final userModel = AuthController.userModel;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (!isProfileScreen) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Userprofile()),
                );
              }
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: _shouldShowPhoto(userModel?.photo)
                  ? MemoryImage(base64Decode(userModel!.photo!))
                  : const NetworkImage(
                  'https://i2.wp.com/www.marismith.com/wp-content/uploads/2014/07/facebook-profile-blank-face.jpeg')
              as ImageProvider,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfile(
                    onProfileUpdated: onProfileUpdated,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel?.fullname ?? "Unknown",
                  style: textStyle.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userModel?.email ?? "unknown",
                  style: textStyle.bodySmall?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => _logout(context),
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}