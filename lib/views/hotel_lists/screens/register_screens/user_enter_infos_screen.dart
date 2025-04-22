import 'package:flutter/material.dart';
import 'package:hotel_app/models/user_auth_model.dart';
import 'package:hotel_app/viewmodels/user_auth_viewmodel.dart';
import 'package:hotel_app/views/hotel_lists/screens/register_screens/login_in_screen.dart';
import 'package:hotel_app/views/profile/extension/space_extension.dart';

class UserEnterInfosScreen extends StatefulWidget {
  final UserAuth user;

  const UserEnterInfosScreen({super.key, required this.user});

  @override
  State<UserEnterInfosScreen> createState() => _UserEnterInfosScreenState();
}

class _UserEnterInfosScreenState extends State<UserEnterInfosScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String message = '';

  void handleSave() async {
    final updatedUser = UserAuth(
      login: widget.user.login,
      password: widget.user.password,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      birthDate: birthDateController.text.trim(),
      gender: genderController.text.trim(),
    );

    final success = await UserAuthController().updateUserInfos(updatedUser);

    setState(() {
      message = success ? "Ma'lumotlar saqlandi!" : "Xatolik yuz berdi.";
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => LoginInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foydalanuvchi ma`lumotlari')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.h,
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(
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
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
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
                controller: birthDateController,
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  labelStyle: TextStyle(
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
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              30.h,
              TextButton(
                onPressed: handleSave,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Saqlash',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              20.h,
              if (message.isNotEmpty)
                Text(
                  message,
                  style: TextStyle(
                    color:
                        message.contains('Saqlandi')
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
