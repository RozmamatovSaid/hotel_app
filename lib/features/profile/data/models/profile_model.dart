import 'package:json_annotation/json_annotation.dart';
import 'bookings_model.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  String birthDate;
  Map<String, BookingsModel> bookings;
  String firstName;
  String lastName;
  String gender;
  String login;
  String password;

  ProfileModel({
    required this.birthDate,
    required this.bookings,
    required this.login,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.password,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileModelToJson(this);
  }

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? login,
    String? password,
    String? birthDate,
  }) {
    return ProfileModel(
      birthDate: birthDate ?? this.birthDate,
      bookings: bookings,
      login: login ?? this.login,
      firstName: firstName ?? this.firstName,
      gender: gender ?? this.gender,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }
}
