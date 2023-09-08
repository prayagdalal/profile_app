import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_module/app_colors.dart';
import 'package:login_module/presentation/home/home_screen.dart';
import 'package:login_module/rounded_checkbox.dart';
import 'package:login_module/utils/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? email = '';
  String? password = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  enabled: true,
                  isDense: true,
                  hintText: 'Email',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: Colors.red)),
                ),
                validator: (value) {
                  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                // Save email to SharedPreferences when "Remember me" is checked
                onSaved: (value) {
                  // Implementation here
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  enabled: true,
                  isDense: true,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: Colors.red)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
                // Save password to SharedPreferences when "Remember me" is checked
                onSaved: (value) {
                  // Implementation here
                },
              ),
              const SizedBox(height: 16),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedCheckbox(
                      value: isChecked,
                      onChanged: (bool val) {
                        setState(() {
                          isChecked = val;
                          log(val.toString());
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                        child: Text(
                      'Remember Me',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.k344054,
                      ),
                    ))
                  ]),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // if (_emailController.text.trim().toString() == SharedPreferencesUtils.getEmail().toString() &&
                      //     _passwordController.text.trim().toString() ==
                      //         SharedPreferencesUtils.getPassword().toString()) {
                      //   Navigator.of(context).pushAndRemoveUntil(
                      //       MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text(
                      //       'Invalid Username or Password',
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                      //     ),
                      //     backgroundColor: Colors.redAccent,
                      //   ));
                      // }

                      await SharedPreferencesUtils.saveLoginData(_emailController.text, _passwordController.text,
                          _emailController.text, '3 years', 'Flutter', isChecked);
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text(
                      //     'Email and password stored',
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                      //   ),
                      //   backgroundColor: Colors.greenAccent,
                      // ));

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: AppColors.black,
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
