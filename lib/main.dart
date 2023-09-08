import 'package:flutter/material.dart';
import 'package:login_module/presentation/home/home_screen.dart';
import 'package:login_module/presentation/login/login_screen.dart';
import 'package:login_module/utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtils.init();
  // final isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isLoggedIn;

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Name',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: (SharedPreferencesUtils.getEmail() == null ||
                SharedPreferencesUtils.getPassword() == null ||
                SharedPreferencesUtils.keepLogin() == false)
            ? const LoginPage()
            : const HomePage());
  }
}



// Implement LoginPage, HomePage, and EditProfilePage as described in previous steps
