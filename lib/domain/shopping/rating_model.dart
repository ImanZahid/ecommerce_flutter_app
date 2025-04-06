
class RatingModel {
  final String username;
  final String dressname;
  final double star; // value between 1 and 5
  final String comment;

  RatingModel({
    required this.username,
    required this.dressname,
    required this.star,
    required this.comment,
  });

  @override
  String toString() {
    return 'RatingModel(username: $username, dress: $dressname, star: $star, comment: $comment)';
  }
}
