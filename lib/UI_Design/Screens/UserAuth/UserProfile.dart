import 'package:flutter/material.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';
import 'package:todo_api_app/API/DataModels/UserProfileModel.dart';
import 'package:todo_api_app/UI_Design/Widgets/App_Bar.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  UserProfileModel? profile;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _showProfile();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showProfile() async {
    setState(() {
      isLoading = true;
    });

    Networkresponse response =
    await NetworkClient().getRequest(url: Urls.ProfileDetails);

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      try {
        UserProfileModel model = UserProfileModel.fromJson(response.body ?? {});
        setState(() {
          profile = model;
        });
      } catch (e) {
        showMessage("Parsing Error: ${e.toString()}");
      }
    } else {
      showMessage("Profile Fetch Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: App_Bar(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(child: Text(error!))
            : profile == null
            ? const Center(child: Text("Profile data not available"))
            : Column(
          children: [
            Container(

              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                boxShadow: [
                  BoxShadow(

                    color: Colors.blue.shade300,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10,

                  )
                ]
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          profile!.photo.isNotEmpty
                              ? profile!.photo
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOVriLPru6AjmM5u0mjgJA67XQfeM27a1gAA&s',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 350,
                width: double.maxFinite,
                child: Card(
                  color: Colors.blue.shade100,
                  elevation: 10,
                  shadowColor: Colors.blue.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${profile!.firstName} ${profile!.lastName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profile!.email,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile!.mobile,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
