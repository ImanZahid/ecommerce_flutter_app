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

  Future<void> createDressRating(RatingModel dressRating) async {
    Object dressRatingObject = dressRating.toMap();
    await firebaseFirestore.collection('dressRatings').add(dressRatingObject as Map<String, dynamic>);

  }

  Future<List<RatingModel>> getDressRatings () async {
    final QuerySnapshot<Map<String, dynamic>> ratings = await firebaseFirestore.collection('dressRatings').get();
    return ratings.docs.map((doc) => {
      RatingModel.fromMap(doc.data())
    }).toList() as List<RatingModel>;
  }
}
