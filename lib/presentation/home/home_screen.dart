import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_module/presentation/login/login_screen.dart';
import 'package:login_module/presentation/profile/edit_profile.dart';
import 'package:login_module/utils/app_colors.dart';
import 'package:login_module/utils/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = '';
  String name = '';
  String skill = '';
  String workExperience = '';
  late String avatarImagePath; // Initialize with the saved image path.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofiledata();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Save the selected image path to SharedPreferences.
      SharedPreferencesUtils.setImage(pickedFile.path);

      setState(() {
        avatarImagePath = pickedFile.path;
      });
    }
  }

  getprofiledata() {
    setState(() {
      email = SharedPreferencesUtils.getEmail()!;
      name = SharedPreferencesUtils.getName()!;
      skill = SharedPreferencesUtils.getSkill()!;
      workExperience = SharedPreferencesUtils.getExp()!;
      avatarImagePath = SharedPreferencesUtils.getImage()!;
    });
  }

  Future<void> _loadSavedImage() async {
    final savedImagePath = SharedPreferencesUtils.getImage();
    setState(() {
      avatarImagePath = savedImagePath!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.black,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              // Logout logic here
              if (SharedPreferencesUtils.keepLogin() == true) {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(), // Replace with your login screen widget
                    ),
                  );
                });
              } else {
                SharedPreferencesUtils.clearSessionData(context);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: avatarImagePath == ''
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('assets/profile.jpg'),
                            radius: 50.0,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(avatarImagePath)),
                            radius: 50.0,
                          )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const Divider(
              thickness: 1.4,
            ),
            Row(
              children: [
                Text(
                  'Name: $name',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () async {
                    final reLoadPage = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                              fieldName: 'Name',
                              fieldData: name,
                            )));
                    if (reLoadPage == true) {
                      getprofiledata();
                    }
                  },
                  icon: const Icon(Icons.edit_square),
                  iconSize: 18,
                )
              ],
            ),

            Row(
              children: [
                Text(
                  'Experience: ${SharedPreferencesUtils.getExp()}',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () async {
                    final reLoadPage = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                              fieldName: 'Experience',
                              fieldData: workExperience,
                            )));
                    if (reLoadPage == true) {
                      getprofiledata();
                    }
                  },
                  icon: const Icon(Icons.edit_square),
                  iconSize: 18,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Skills: ${SharedPreferencesUtils.getSkill()}',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () async {
                    final reLoadPage = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                              fieldName: 'Skills',
                              fieldData: skill,
                            )));
                    if (reLoadPage == true) {
                      getprofiledata();
                    }
                  },
                  icon: const Icon(Icons.edit_square),
                  iconSize: 18,
                )
              ],
            ),

            // Add other user info fields here
          ],
        ),
      ),
    );
  }
}
