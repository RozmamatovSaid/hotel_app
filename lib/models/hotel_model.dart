import 'package:hotel_app/models/review_model.dart';

class HotelModel {
  String? id;
  final String name;
  final String address;
  final String description;
  final List<String> facilities;
  final List<String> image;
  final int price;
  double rating;
  final List<String> type;
  final List<ReviewModel> reviews;

  HotelModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.facilities,
    required this.image,
    required this.price,
    required this.rating,
    required this.type,
    required this.reviews,
  });

  factory HotelModel.fromJson({required Map<String, dynamic> json, String? id}) {
    return HotelModel(
      id: id,
      name: json['name'],
      address: json['address'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']),
      image: List<String>.from(json['image']),
      price: json['price'],
      rating: (json['rating'] as num).toDouble(),
      type: List<String>.from(json['type']),
      reviews:
          (json['review'] as Map<String, dynamic>?)?.values
              .map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}