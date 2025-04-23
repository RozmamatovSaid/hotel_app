import 'package:flutter/material.dart';
import '../../../data/datasources/auth_remote_datasources.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final AuthRemoteDataSources authController = AuthRemoteDataSources();

  String message = '';

  void resetPassword() async {
    final login = loginController.text.trim();
    final newPassword = newPasswordController.text;

    if (login.isEmpty || newPassword.isEmpty) {
      setState(() {
        message = 'Barcha ma`lumotlarni to`ldiring';
      });
      return;
    }

    try {
      await authController.updatePassword(login, newPassword);
      setState(() {
        message = 'Parol muvaffaqiyatli yangilandi!';
      });

      loginController.clear();
      newPasswordController.clear();
    } catch (e) {
      setState(() {
        message = 'Login topilmadi yoki xatolik yuz berdi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email or Number',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: resetPassword,
              child: const Text(
                'Parolni yangilash',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                color:
                    message.contains('muvaffaqiyatli')
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
