import 'dart:convert';
import 'package:hotel_app/models/user_auth_model.dart';
import 'package:http/http.dart' as http;

class UserAuthController {
  final String url =
      'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users.json';

  Future<List<UserAuth>> getAllUsers() async {
    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body) as Map<String, dynamic>;
    return data.values.map((e) => UserAuth.fromJson(e)).toList();
  }

  Future<void> addUser(UserAuth user) async {
    final respons = await http.post(
      Uri.parse(url),
      body: json.encode(user.toJson()),
    );
  }

  Future<Map<String, UserAuth>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> data = json.decode(response.body);
    return data.map((key, value) => MapEntry(key, UserAuth.fromJson(value)));
  }

  Future<void> updatePassword(String login, String newPassword) async {
    final users = await fetchUsers();

    final entry = users.entries.firstWhere((e) => e.value.login == login);

    final patchUrl =
        'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/${entry.key}.json';

    await http.patch(
      Uri.parse(patchUrl),
      body: json.encode({'password': newPassword}),
    );
  }

  Future<bool> updateUserInfos(UserAuth user) async {
    final users = await fetchUsers();

    final entry = users.entries.firstWhere(
      (e) => e.value.login == user.login,
      orElse: () => MapEntry('', UserAuth(login: '', password: '')),
    );

    if (entry.key.isEmpty) return false;

    final url =
        'https://e-commerce-d13dc-default-rtdb.firebaseio.com/hotel/users/${entry.key}.json';

    final response = await http.patch(
      Uri.parse(url),
      body: json.encode({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'birthDate': user.birthDate,
        'gender': user.gender,
      }),
    );

    return response.statusCode == 200;
  }
}
