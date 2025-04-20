import 'dart:convert';
import 'package:hotel_app/models/profile_model.dart';
import "package:http/http.dart" as http;

class ProfileViewmodel {
  Future<ProfileModel?> getUser() async {
  ProfileModel? user;
  final uri = Uri.parse(
      "https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users.json");

  try {
    final response = await http.get(uri);
    final decoded = jsonDecode(response.body);

    if (decoded is Map<String, dynamic>) {
      user = ProfileModel.fromMap(decoded);
    } else {
      print("⚠️ Not a valid user data: $decoded");
    }
  } catch (e, c) {
    print(e);
    print(c);
  }

  return user;
}

}
