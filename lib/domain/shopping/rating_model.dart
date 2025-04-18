// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class RatingModel {
  final String userId;
  final String dressId;
  final double star; // value between 1 and 5
  final String comment;

  RatingModel({
    required this.userId,
    required this.dressId,
    required this.star,
    required this.comment,
  });

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      userId: map['userId'] as String,
      dressId: map['dressId'] as String,
      star: map['star'] as double,
      comment: map['comment'] as String,
    );
  }

  //TODO
  //grab names from the related user and dress tables
  @override
  String toString() {
    return 'RatingModel(userId: $userId, dressId: $dressId, star: $star, comment: $comment)';
  }

  RatingModel copyWith({
    String? userId,
    String? dressId,
    double? star,
    String? comment,
  }) {
    return RatingModel(
      userId: userId ?? this.userId,
      dressId: dressId ?? this.dressId,
      star: star ?? this.star,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'dressId': dressId,
      'star': star,
      'comment': comment,
    };
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) => RatingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant RatingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.dressId == dressId &&
      other.star == star &&
      other.comment == comment;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      dressId.hashCode ^
      star.hashCode ^
      comment.hashCode;
  }
}
