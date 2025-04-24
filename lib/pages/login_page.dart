import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:explorer_web/components/my_button.dart';
import 'package:explorer_web/components/text_field.dart';
import 'package:explorer_web/services/auth/auth_service.dart';
import 'package:explorer_web/colors.dart';
import 'package:explorer_web/utils.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final universityController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text, 
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: explorerBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
                explorerLogoWhite,
                height: 100,
              ),
          ),
        
        const SizedBox(height: 100),

         SizedBox(
            width: 500,
           child: MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
            ),
         ),

          const SizedBox(height: 12),
        
          SizedBox(
            width: 500,
            child: MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: 500,
            child: MyButton(onTap: signIn, text: "Sign in", color: Colors.black,)),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
            ],)
        
        
        ],),
      )
    );
  }
}