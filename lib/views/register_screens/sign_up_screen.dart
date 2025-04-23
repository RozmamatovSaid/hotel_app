import 'package:flutter/material.dart';
import 'package:hotel_app/models/user_auth_model.dart';
import 'package:hotel_app/datasources/auth_remote_datasources.dart';
import 'package:hotel_app/views/profile/extension/space_extension.dart';
import 'package:hotel_app/views/register_screens/login_in_screen.dart';
import 'package:hotel_app/views/register_screens/user_enter_infos_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final AuthRemoteDataSources userAuthController = AuthRemoteDataSources();

  String errorMessage = '';

  void handleSignUp() async {
    final login = loginController.text.trim();
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (login.isEmpty || password.isEmpty || rePassword.isEmpty) {
      setState(() {
        errorMessage = "Barcha ma`lumotlarni to`ldiring.";
      });
      return;
    }

    if (password != rePassword) {
      setState(() {
        errorMessage = "Parollar mos emas.";
      });
      return;
    }

    final newUser = UserAuthModel(login: login, password: password);

    await userAuthController.addUser(newUser);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => UserEnterInfosScreen(user: newUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: const Alignment(0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              50.h,
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                  hintText: 'Enter email or number',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              20.h,
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              20.h,
              TextField(
                controller: rePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Re-enter password',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty) ...[
                10.h,
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              20.h,
              TextButton(
                onPressed: handleSignUp,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(350, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  overlayColor: Colors.transparent,
                  minimumSize: const Size(10, 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginInScreen()),
                  );
                },
                child: const Align(
                  alignment: Alignment(1, 1),
                  child: Text(
                    'Have you login in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: -1,
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
