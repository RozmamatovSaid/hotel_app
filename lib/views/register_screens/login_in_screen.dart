import 'package:flutter/material.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:hotel_app/models/user_auth_model.dart';
import 'package:hotel_app/datasources/auth_remote_datasources.dart';
import 'package:hotel_app/viewmodels/auth_viewmodel.dart';
import 'package:hotel_app/views/profile/extension/space_extension.dart';
import 'package:hotel_app/views/register_screens/forgot_password_screen.dart';
import 'package:hotel_app/views/register_screens/sign_up_screen.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRemoteDataSources userAuthController = AuthRemoteDataSources();

  String errorMessage = '';
  final authViewModel = AuthViewmodel();

  void handleLogin() async {
    final login = loginController.text.trim();
    final password = passwordController.text;

    final List<UserAuthModel> users = await userAuthController.getAllUsers();

    final matchedUser = users.firstWhere(
      (user) => user.login == login && user.password == password,
      orElse: () => UserAuthModel(login: '', password: ''),
    );
    
    if (matchedUser.login.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.categories);
    } else {
      setState(() {
        errorMessage = 'Xato login yoki parol';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: const Alignment(0, -0.2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              if (errorMessage.isNotEmpty) ...[
                10.h,
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              TextButton(
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const SignUpScreen()),
                  );
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Have you not login in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => ForgotPasswordScreen()),
                  );
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot your Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
              40.h,
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(350, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: handleLogin,
                child: const Text(
                  'Login In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.white,
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
