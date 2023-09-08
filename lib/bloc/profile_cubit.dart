// profile_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<Map<String, String>> {
  ProfileCubit() : super({});

  Future<void> loadUserProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final email = sharedPreferences.getString('email') ?? 'admin@gmail.com';
    final name = sharedPreferences.getString('name') ?? 'Admin';
    // Load other profile information from SharedPreferences

    final userProfile = {
      'email': email,
      'name': name,
      // Add other profile information here
    };

    emit(userProfile);
  }

  Future<void> updateProfile(Map<String, String> updatedProfile) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', updatedProfile['email']!);
    sharedPreferences.setString('name', updatedProfile['name']!);
    // Update other profile information in SharedPreferences

    emit(updatedProfile);
  }
}
