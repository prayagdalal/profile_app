// authentication_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<bool> {
  AuthenticationCubit() : super(false);

  Future<void> login() async {
    // Perform login logic here (e.g., check credentials)
    final sharedPreferences = await SharedPreferences.getInstance();
    final email = sharedPreferences.getString('email') ?? 'admin@gmail.com';
    final password = sharedPreferences.getString('password') ?? 'Admin@1234';

    // Simulate successful login
    if (email == 'admin@gmail.com' && password == 'Admin@1234') {
      sharedPreferences.setBool('isLoggedIn', true);
      emit(true); // User is logged in
    }
  }

  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLoggedIn', false);
    emit(false); // User is logged out
  }
}
