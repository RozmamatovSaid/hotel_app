// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingsModel _$BookingsModelFromJson(
  Map<String, dynamic> json,
) => BookingsModel(
  name: json['name'] as String,
  endDate: json['endDate'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  startDate: json['startDate'] as String,
  facilities:
      (json['facilities'] as List<dynamic>).map((e) => e as String).toList(),
  totalPrice: (json['totalPrice'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$BookingsModelToJson(BookingsModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'endDate': instance.endDate,
      'facilities': instance.facilities,
      'images': instance.images,
      'name': instance.name,
      'startDate': instance.startDate,
      'totalPrice': instance.totalPrice,
      'type': instance.type,
    };
