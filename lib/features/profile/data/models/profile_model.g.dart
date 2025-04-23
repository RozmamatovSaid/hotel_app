// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  birthDate: json['birthDate'] as String,
  bookings: (json['bookings'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, BookingsModel.fromJson(e as Map<String, dynamic>)),
  ),
  login: json['login'] as String,
  firstName: json['firstName'] as String,
  gender: json['gender'] as String,
  lastName: json['lastName'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'bookings': instance.bookings,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'login': instance.login,
      'password': instance.password,
    };
