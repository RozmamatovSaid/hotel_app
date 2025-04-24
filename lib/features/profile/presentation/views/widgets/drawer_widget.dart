import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/presentation/extension/space_extension.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/bookins_list.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/profile_screen.dart';
import 'package:hotel_app/features/profile/presentation/views/screens/splash_screen.dart';
import '../../../data/models/profile_model.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../widgets/tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = ProfileViewmodel();
    bool isCash = false;

    return FutureBuilder<ProfileModel?>(
      future: viewmodel.getUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("Foydalanuvchi topilmadi"));
        }

        final user = snapshot.data!;

        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(child: Icon(Icons.person), radius: 30),
                        15.h,
                        Text(user.firstName),
                        Text(user.login),
                      ],
                    ),
                  ],
                ),
              ),
              Tile(
                ikon: Icon(Icons.person),
                subtitle: "Shaxsiy ma'lumotlarni ko'rish va tahrirlash",
                title: "Akkount Sozlamalari",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              Tile(
                ikon: Icon(Icons.history),
                subtitle: "Hozirda band qilingan mehmonxonalar",
                title: "Mehmonxonalar tarixi",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BookinsList(bookings: user.bookings),
                    ),
                  );
                },
              ),
              Tile(
                ikon: Icon(Icons.wallet),
                subtitle: "To'lov usullarini boshqarish (Naqd yoki karta)",
                title: "Boshqaruv",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("To'lov uslubi"),
                                ListTile(
                                  leading: Icon(Icons.money),
                                  title: Text("Naqt to'lash"),
                                  trailing:
                                      isCash
                                          ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                          : null,
                                  onTap: () {
                                    setModalState(() {
                                      isCash = true;
                                    });
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.credit_card),
                                  title: Text("Karta orqali"),
                                  trailing:
                                      !isCash
                                          ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                          : null,
                                  onTap: () {
                                    setModalState(() {
                                      isCash = false;
                                    });
                                  },
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Saqlash"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Tile(
                ikon: Icon(Icons.logout),
                subtitle: "Akkountni o'chrb bosh sahifaga qaytish",
                title: "Akkountni ochrsh",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (ctx) => SplashScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
