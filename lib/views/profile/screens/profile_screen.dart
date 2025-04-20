import 'package:flutter/material.dart';
import 'package:hotel_app/models/profile_model.dart';
import 'package:hotel_app/viewmodels/profile_viewmodel.dart';
import 'package:hotel_app/views/profile/screens/screen.dart';
import 'package:hotel_app/views/profile/widgets/line.dart';
import 'package:hotel_app/views/profile/extension/space_extension.dart';
import 'package:hotel_app/views/profile/widgets/log_out_textbotton.dart';
import 'package:hotel_app/views/profile/widgets/rich_text_widget.dart';
import 'package:hotel_app/views/profile/widgets/tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vievmodel = ProfileViewmodel();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Screen()),
              );
            },
            icon: Icon(Icons.abc),
          ),
        ],
      ),
      body: FutureBuilder<ProfileModel?>(
        future: vievmodel.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.stackTrace);
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null) {
            return Center(child: Text('No data available'));
          }
          final user = snapshot.data!;
          // final bottomSize = MediaQuery.of(context).viewInsets.bottom + 20;

          return Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Line(),
                    27.h,
                    CircleAvatar(backgroundColor: Colors.amber, radius: 50),
                    15.h,
                    Text(
                      "${user.lastName} ${user.firstName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    20.h,
                    Line(),
                    Tile(
                      ikon: Icon(Icons.person),
                      subtitle: "Shaxsiy ma'lumotlarni ko'rish va tahrirlash",
                      title: "Akkount Sozlamalari",
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Akkount sozlamalari: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    RichTextWidget(
                                      subtitle: "Ism",
                                      title: user.firstName,
                                    ),
                                    RichTextWidget(
                                      subtitle: "Familiya",
                                      title: user.lastName,
                                    ),
                                    RichTextWidget(
                                      subtitle: "Telefon raqam",
                                      title: user.phoneNumber,
                                    ),
                                    RichTextWidget(
                                      subtitle: "Jinsi",
                                      title: user.gender,
                                    ),
                                    RichTextWidget(
                                      subtitle: "Tug'ilgan kun",
                                      title: user.birthDate,
                                    ),
                                    Align(
                                      alignment: Alignment(1, 1),
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom +
                                                        20,
                                                  ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  25,
                                                                ),
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16,
                                                          ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        spacing: 10,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Taxrirlash"),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Ism",
                                                                ),
                                                          ),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Familiya",
                                                                ),
                                                          ),
                                                          TextField(
                                                            decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  "Telefon raqam",
                                                            ),
                                                          ),
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Jinsi",
                                                                ),
                                                          ),
                                                          TextField(
                                                            decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  "Tug'ilgan kun",
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                Alignment(1, 1),
                                                            child:
                                                                FloatingActionButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                  ),
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    20.h,
                    Line(),
                    Tile(
                      ikon: Icon(Icons.history),
                      subtitle: "Hozirda band qilingan mehmonxonalar",
                      title: "Mehmonxonalar tarixi",
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ism: "),
                                    Text("Familiya: "),
                                    Text("Telefon raqam:"),
                                    Text("Jinsi:"),
                                    Text("Tug'ilgan kun:"),
                                    Align(
                                      alignment: Alignment(1, 1),
                                      child: FloatingActionButton(
                                        onPressed: () {},
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    20.h,
                    Line(),
                    Tile(
                      ikon: Icon(Icons.wallet),
                      subtitle:
                          "To'lov usullarini boshqarish (Naqd yoki karta)",
                      title: "Boshqaruv",
                      onTap: () {
                        Tile(
                          ikon: Icon(Icons.wallet),
                          title: "Boshqaruv",
                          subtitle:
                              "To'lov usullarini boshqarish (Naqd yoki karta)",
                          onTap: () {},
                        );
                      },
                    ),
                    20.h,
                    LogOutTextbotton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
