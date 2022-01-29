import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mereter/login_screen.dart';
import 'package:mereter/main_menu_loading_screen.dart';
import 'package:mereter/personal_data_edit.dart';
import 'package:mereter/personal_details.dart';
import 'package:mereter/registration_screen.dart';
import 'package:mereter/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Mereter());
}

class Mereter extends StatelessWidget {
  const Mereter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: InitialScreen.id,
      routes: {
        InitialScreen.id: (context) => const InitialScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        MainMenuLoadingScreen.id: (context) => const MainMenuLoadingScreen(),
        PersonalDetailsScreen.id: (context) => const PersonalDetailsScreen(),
      },
    );
  }
}
