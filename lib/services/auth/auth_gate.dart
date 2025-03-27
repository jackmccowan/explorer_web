import 'package:explorer_web/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:explorer_web/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking auth state
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // If logged in, show MainScreen with BottomNavigationBar
            return MainScreen();
          } else {
            // If not logged in, show Login/Register screen
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
