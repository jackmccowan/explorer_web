import 'package:explorer_web/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:explorer_web/components/my_button.dart';
import 'package:explorer_web/components/text_field.dart';
import 'package:explorer_web/services/auth/auth_service.dart';
import 'package:explorer_web/utils.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final universityController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match mate"),
      )
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text, firstNameController.text, lastNameController.text, universityController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
            padding: EdgeInsets.all(60.0),
            child: Image.asset(
                explorerLogo,
                height: 100,
              ),
          ),
          const Text("Create an account", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),

        const SizedBox(height: 12),

         SizedBox(
            width: 500,
           child: MyTextField(
            controller: firstNameController,
            hintText: 'First Name',
            obscureText: false,
            ),
         ),

        const SizedBox(height: 12),

         SizedBox(
            width: 500,
           child: MyTextField(
            controller: lastNameController,
            hintText: 'Last Name',
            obscureText: false,
            ),
         ),

        const SizedBox(height: 12),

        SizedBox(
            width: 500,
           child: MyTextField(
            controller: universityController,
            hintText: 'University', //this needs to be changed to a dropdown
            obscureText: false,
            ),
         ),

        const SizedBox(height: 12),
        

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

            const SizedBox(height: 12),

          SizedBox(
            width: 500,
            child: MyTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: true,
            ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: 500,
            child: MyButton(onTap: signUp, text: "Sign up", color: Colors.black)),

          const SizedBox(height: 12),

           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: const Text('Login instead ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
            ],)
        
        
        ],),
      )
    );
}}