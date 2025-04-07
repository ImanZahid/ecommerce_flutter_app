
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
    return RatingModel(userId: map['userId'],
                      dressId: map['dressId'], 
                      star: map['star'], 
                      comment: map['comment']);
  }

  //TODO
  //grab names from the related user and dress tables
  @override
  String toString() {
    return 'RatingModel(userId: $userId, dressId: $dressId, star: $star, comment: $comment)';
  }
}
