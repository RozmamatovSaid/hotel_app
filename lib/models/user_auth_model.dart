class UserAuth {
  final String login;
  final String password;
  final String birthDate;
  final String firstName;
  final String lastName;
  final String gender;
  // final List<String> booking;

  UserAuth({
    required this.login,
    required this.password,
    this.birthDate = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
  });
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      login: json['login'].toString(),
      password: json['password'].toString(),
      birthDate: json['birthDate'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      gender: json['gender'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'birthDate': birthDate,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
    };
  }
}
