import 'package:json_annotation/json_annotation.dart';

part 'bookings_model.g.dart';

@JsonSerializable()
class BookingsModel {
  final String description;
  final String endDate;
  final List<String> facilities;
  final List<String> images;
  final String name;
  final String startDate;
  final int totalPrice;
  final String type;

  BookingsModel({
    required this.name,
    required this.endDate,
    required this.description,
    required this.images,
    required this.startDate,
    required this.facilities,
    required this.totalPrice,
    required this.type,
  });

  factory BookingsModel.fromJson(Map<String, dynamic> json) {
    return _$BookingsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BookingsModelToJson(this);
  }
}
