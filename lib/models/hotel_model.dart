import 'review_model.dart';

class HotelModel {
  final String address;
  final String description;
  final List<String> facilities;
  final List<String> image;
  final String name;
  final int price;
  final int rating;
  final Map<String, ReviewModel> review;
  final List<String> type;

  HotelModel({
    required this.address,
    required this.description,
    required this.facilities,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.review,
    required this.type,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      address: json['address'],
      description: json['description'] ?? '',
      facilities: List<String>.from(json['facilities'] ?? []),
      image: List<String>.from(json['image'] ?? []),
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      review: (json['review'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, ReviewModel.fromJson(value)),
      ),
      type: List<String>.from(json['type'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'description': description,
      'facilities': facilities,
      'image': image,
      'name': name,
      'price': price,
      'rating': rating,
      'review': review.map((key, value) => MapEntry(key, value.toJson())),
      'type': type,
    };
  }

  HotelModel copyWith({
    String? address,
    String? description,
    List<String>? facilities,
    List<String>? image,
    String? name,
    int? price,
    int? rating,
    Map<String, ReviewModel>? review,
    List<String>? type,
  }) {
    return HotelModel(
      address: address ?? this.address,
      description: description ?? this.description,
      facilities: facilities ?? this.facilities,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      type: type ?? this.type,
    );
  }
}
