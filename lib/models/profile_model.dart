import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  String firstName;
  String lastName;
  String gender;
  String email;
  String phoneNumber;
  Map<String, dynamic> bookings;
  String birthDate;

  ProfileModel(
      {required this.birthDate,
      required this.bookings,
      required this.email,
      required this.firstName,
      required this.gender,
      required this.lastName,
      required this.phoneNumber});

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
    String? email,
    String? phoneNumber,
    String? birthDate,
  }) {
    return ProfileModel(
        birthDate: birthDate ?? this.birthDate,
        bookings: bookings,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
