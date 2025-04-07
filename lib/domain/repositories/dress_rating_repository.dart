import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter_app/domain/exceptions/firebase_document_exception.dart';
import 'package:ecommerce_flutter_app/domain/shopping/rating_model.dart';

class DressRatingRepository {
  final FirebaseFirestore firebaseFirestore;
  DressRatingRepository({required this.firebaseFirestore});

  Future<RatingModel> getDressRating(String ratingId) async {
     final DocumentSnapshot dressRating = await firebaseFirestore.collection('dressRatings').doc(ratingId).get();
     if (!dressRating.exists) {
        throw FirebaseDocumentNotFound('Dress Rating with the ratingId $ratingId not found!');
     }
      return RatingModel.fromMap(dressRating.data()! as Map<String, dynamic>);
  }
}
