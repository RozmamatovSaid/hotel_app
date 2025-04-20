import 'dart:convert';

import 'package:hotel_app/models/profile_model.dart';
import "package:http/http.dart" as http;

class ProfileViewmodel {
  Future<List<ProfileModel>> getUser() async {
    final uri = Uri.parse(
        "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users.json");

    final response = await http.get(uri);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    List<ProfileModel> users = [];
    decoded.forEach((key, value) {
      users.add(ProfileModel.fromMap(value));
    });
    return users;
  }
}
