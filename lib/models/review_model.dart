class ReviewModel {
  final String comment;
  final int rating;

  ReviewModel({
    required this.comment,
    required this.rating,
  });

factory ReviewModel.fromJson(Map<String, dynamic> json) {
  return ReviewModel(
    comment: json['comment'] ?? '',
    rating: (json['rating'] as num?)?.toInt() ?? 0,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'rating': rating,
    };
  }

  ReviewModel copyWith({
    String? comment,
    int? rating,
  }) {
    return ReviewModel(
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
    );
  }
}
