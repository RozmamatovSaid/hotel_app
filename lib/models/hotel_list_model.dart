class Hotel {
  final String id;
  final String name;
  final String description;
  final List<String> facilities;
  final List<String> image;
  final int price;
  final int rating;
  final List<String> type;
  final List<Review> reviews;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.facilities,
    required this.image,
    required this.price,
    required this.rating,
    required this.type,
    required this.reviews,
  });

  factory Hotel.fromJson(Map<String, dynamic> json, String id) {
    return Hotel(
      id: id,
      name: json['name'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']),
      image: List<String>.from(json['image']),
      price: json['price'],
      rating: (json['rating'] as num).toInt(),
      type: List<String>.from(json['type']),
      reviews:
          (json['review'] as Map<String, dynamic>?)?.values
              .map((e) => Review.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Review {
  final String comment;
  final int rating;

  Review({required this.comment, required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(comment: json['comment'], rating: json['rating']);
  }

  Map<String, dynamic> toJson() {
    return {'comment': comment, 'rating': rating};
  }
}
