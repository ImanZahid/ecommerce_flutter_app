import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter_app/domain/exceptions/firebase_document_exception.dart';
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';

class DressRepository {
  final FirebaseFirestore firebaseFirestore;
  DressRepository({required this.firebaseFirestore});

  Future<DressModel> getDress(String dressId) async {
     final DocumentSnapshot dress = await firebaseFirestore.collection('dresses').doc(dressId).get();
     if (!dress.exists) {
        throw FirebaseDocumentNotFound('Dress with the dressId $dressId not found!');
     }
      return DressModel.fromMap(dress.data()! as Map<String, dynamic>);
  }
}
