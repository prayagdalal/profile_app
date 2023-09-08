import 'package:flutter/material.dart';
import 'package:login_module/presentation/home/home_screen.dart';
import 'package:login_module/presentation/login/login_screen.dart';
import 'package:login_module/utils/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Profile App',
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
